from typing import Any, List, Optional, Dict

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session

from ...db.session import get_db
from ...schemas.persona import Persona, PersonaCreate, PersonaUpdate
from ...services.persona import persona_service
from ...core.security import get_current_user, get_optional_current_user

router = APIRouter()

@router.get("/", response_model=List[Persona])
def read_personas(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,
    name: Optional[str] = None,
    current_user: Optional[Dict] = Depends(get_optional_current_user),
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
    current_user: Dict = Depends(get_current_user),
) -> Any:
    """
    Create new persona. Requires authentication.
    """
    persona = persona_service.create(db, obj_in=persona_in)
    return persona

@router.get("/me", response_model=Dict)
def get_user_info(
    current_user: Dict = Depends(get_current_user),
) -> Dict:
    """
    Get current user information. Requires authentication.
    """
    return current_user

@router.get("/{persona_id}", response_model=Persona)
def read_persona(
    *,
    db: Session = Depends(get_db),
    persona_id: int,
    current_user: Optional[Dict] = Depends(get_optional_current_user),
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
    current_user: Dict = Depends(get_current_user),
) -> Any:
    """
    Update a persona. Requires authentication.
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
    current_user: Dict = Depends(get_current_user),
) -> Any:
    """
    Delete a persona. Requires authentication.
    """
    persona = persona_service.get(db, id=persona_id)
    if not persona:
        raise HTTPException(status_code=404, detail="Persona not found")
    persona = persona_service.remove(db, id=persona_id)
    return persona 