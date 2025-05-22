from typing import Any, List, Optional

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session

from ...db.session import get_db
from ...schemas.persona import Persona, PersonaCreate, PersonaUpdate
from ...services.persona import persona_service

router = APIRouter()

@router.get("/", response_model=List[Persona])
def read_personas(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,
    name: Optional[str] = None,
) -> Any:
    """
    Retrieve personas.
    """
    personas = persona_service.get_multi(db, skip=skip, limit=limit, name=name)
    return personas

@router.post("/", response_model=Persona)
def create_persona(
    *,
    db: Session = Depends(get_db),
    persona_in: PersonaCreate,
) -> Any:
    """
    Create new persona.
    """
    persona = persona_service.create(db, obj_in=persona_in)
    return persona

@router.get("/{persona_id}", response_model=Persona)
def read_persona(
    *,
    db: Session = Depends(get_db),
    persona_id: int,
) -> Any:
    """
    Get persona by ID.
    """
    persona = persona_service.get(db, id=persona_id)
    if not persona:
        raise HTTPException(status_code=404, detail="Persona not found")
    return persona

@router.put("/{persona_id}", response_model=Persona)
def update_persona(
    *,
    db: Session = Depends(get_db),
    persona_id: int,
    persona_in: PersonaUpdate,
) -> Any:
    """
    Update a persona.
    """
    persona = persona_service.get(db, id=persona_id)
    if not persona:
        raise HTTPException(status_code=404, detail="Persona not found")
    persona = persona_service.update(db, db_obj=persona, obj_in=persona_in)
    return persona

@router.delete("/{persona_id}", response_model=Persona)
def delete_persona(
    *,
    db: Session = Depends(get_db),
    persona_id: int,
) -> Any:
    """
    Delete a persona.
    """
    persona = persona_service.get(db, id=persona_id)
    if not persona:
        raise HTTPException(status_code=404, detail="Persona not found")
    persona = persona_service.remove(db, id=persona_id)
    return persona 