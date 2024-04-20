#!/usr/bin/python3
""" State Module for HBNB project """
from models.base_model import BaseModel
import uuid


class State(BaseModel):
    """ State class """
    def __init__(self, *args, **kwargs):
        """Initializes State instance"""
        super().__init__(*args, **kwargs)
        # Ensure 'id' attribute is set properly
        if 'id' not in kwargs:
            self.id = str(uuid.uuid4())
