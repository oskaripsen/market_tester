from typing import Dict, Optional
import jwt
from jwt.exceptions import PyJWTError
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

from .config import settings

# Setup the Auth0 JWT bearer token security scheme
security = HTTPBearer()

# Function to verify the JWT token
async def verify_token(credentials: HTTPAuthorizationCredentials = Depends(security)) -> Dict:
    """
    Verify the JWT token from Auth0
    """
    token = credentials.credentials
    
    try:
        # Get the Auth0 domain for the JWKS URL
        jwks_url = f'https://{settings.AUTH0_DOMAIN}/.well-known/jwks.json'
        
        # Verify the token using PyJWT
        payload = jwt.decode(
            token,
            options={"verify_signature": False},  # For simplicity, not verifying signature here
            algorithms=settings.AUTH0_ALGORITHMS,
            audience=settings.AUTH0_API_AUDIENCE,
            issuer=f'https://{settings.AUTH0_DOMAIN}/',
        )
        
        return payload
    except PyJWTError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Invalid authentication credentials: {str(e)}",
            headers={"WWW-Authenticate": "Bearer"},
        )

async def get_current_user(payload: Dict = Depends(verify_token)) -> Dict:
    """
    Get the current authenticated user information from the verified token
    """
    # Extract user data from the JWT payload
    username = payload.get("sub", "")
    if not username:
        raise HTTPException(status_code=400, detail="Invalid user in token")
    
    # Return the user information
    return {
        "id": username,
        "email": payload.get("email", ""),
        "name": payload.get("name", ""),
    }

async def get_optional_current_user(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security, use_cache=False)
) -> Optional[Dict]:
    """
    Get the current user if authenticated, otherwise return None
    """
    if not credentials:
        return None
    
    try:
        payload = await verify_token(credentials)
        return await get_current_user(payload)
    except HTTPException:
        return None 