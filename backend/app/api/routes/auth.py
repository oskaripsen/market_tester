from typing import Dict

from fastapi import APIRouter, Depends

from ...core.config import settings
from ...core.security import get_current_user

router = APIRouter()

@router.get("/config")
def get_auth0_config() -> Dict:
    """
    Return Auth0 configuration for the frontend.
    """
    return {
        "domain": settings.AUTH0_DOMAIN,
        "clientId": settings.AUTH0_CLIENT_ID,
        "audience": settings.AUTH0_API_AUDIENCE,
    }

@router.get("/user")
def get_user_info(current_user: Dict = Depends(get_current_user)) -> Dict:
    """
    Return the current user's information.
    Requires authentication.
    """
    return current_user 