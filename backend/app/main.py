from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .core.config import settings

app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json"
)

# Set up CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include API router
from .api.routes import api_router
app.include_router(api_router, prefix=settings.API_V1_STR)

@app.get("/health-check")
async def health_check():
    return {"status": "ok"} 