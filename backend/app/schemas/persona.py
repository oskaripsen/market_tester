from typing import Optional
from datetime import datetime
from pydantic import BaseModel

# Shared properties
class PersonaBase(BaseModel):
    name: str
    description: Optional[str] = None
    age: Optional[int] = None
    income: Optional[int] = None
    occupation: Optional[str] = None

# Properties to receive on item creation
class PersonaCreate(PersonaBase):
    pass

# Properties to receive on item update
class PersonaUpdate(PersonaBase):
    name: Optional[str] = None
    is_active: Optional[bool] = None

# Properties shared by models stored in DB
class PersonaInDBBase(PersonaBase):
    id: int
    is_active: bool
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

# Properties to return to client
class Persona(PersonaInDBBase):
    pass 