from typing import List, Optional, Union, Dict, Any

from sqlalchemy.orm import Session

from ..db.models.persona import Persona
from ..schemas.persona import PersonaCreate, PersonaUpdate

class PersonaService:
    def get(self, db: Session, id: int) -> Optional[Persona]:
        return db.query(Persona).filter(Persona.id == id).first()
    
    def get_multi(
        self, 
        db: Session, 
        *, 
        skip: int = 0, 
        limit: int = 100,
        name: Optional[str] = None
    ) -> List[Persona]:
        query = db.query(Persona)
        if name:
            query = query.filter(Persona.name.ilike(f"%{name}%"))
        return query.offset(skip).limit(limit).all()
    
    def create(self, db: Session, *, obj_in: PersonaCreate) -> Persona:
        obj_in_data = obj_in.model_dump()
        db_obj = Persona(**obj_in_data)
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj
    
    def update(
        self,
        db: Session,
        *,
        db_obj: Persona,
        obj_in: Union[PersonaUpdate, Dict[str, Any]]
    ) -> Persona:
        if isinstance(obj_in, dict):
            update_data = obj_in
        else:
            update_data = obj_in.model_dump(exclude_unset=True)
        for field in update_data:
            setattr(db_obj, field, update_data[field])
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj
    
    def remove(self, db: Session, *, id: int) -> Persona:
        obj = db.query(Persona).get(id)
        db.delete(obj)
        db.commit()
        return obj

persona_service = PersonaService() 