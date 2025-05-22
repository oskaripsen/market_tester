from typing import Generator

from fastapi import Depends

from .base import SessionLocal

def get_db() -> Generator:
    """
    Dependency function that yields db sessions
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close() 