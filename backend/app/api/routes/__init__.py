from fastapi import APIRouter
from .personas import router as personas_router
from .auth import router as auth_router

api_router = APIRouter()
api_router.include_router(personas_router, prefix="/personas", tags=["personas"])
api_router.include_router(auth_router, prefix="/auth", tags=["auth"]) 