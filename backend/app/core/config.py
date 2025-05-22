import os
from typing import List, Union, Optional, Annotated
from pydantic import AnyHttpUrl, Field, model_validator
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    PROJECT_NAME: str = "Market Tester"
    
    # CORS
    CORS_ORIGINS: List[str] = []

    # Database
    SQLALCHEMY_DATABASE_URI: str = "sqlite:///./market_tester.db"
    
    # Auth0 settings
    AUTH0_DOMAIN: str = ""
    AUTH0_API_AUDIENCE: str = ""
    AUTH0_ALGORITHMS: List[str] = ["RS256"]
    AUTH0_ISSUER: str = ""
    AUTH0_CLIENT_ID: str = ""
    AUTH0_CLIENT_SECRET: str = ""
    
    @model_validator(mode='before')
    def validate_cors_origins(cls, values):
        cors_origins = values.get('CORS_ORIGINS')
        if isinstance(cors_origins, str):
            if cors_origins.startswith('[') and cors_origins.endswith(']'):
                # It's a JSON string, let it be parsed by pydantic
                pass
            else:
                # It's a comma-separated string
                values['CORS_ORIGINS'] = [origin.strip() for origin in cors_origins.split(',')]
        return values
    
    model_config = {
        "env_file": ".env",
        "case_sensitive": True,
        "extra": "ignore"
    }


settings = Settings() 