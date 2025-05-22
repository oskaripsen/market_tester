from fastapi import APIRouter
from .personas import router as personas_router

api_router = APIRouter()
api_router.include_router(personas_router, prefix="/personas", tags=["personas"]) 