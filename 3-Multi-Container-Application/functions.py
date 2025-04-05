import random
import string

from db import db
from models import Todo

def fetch_all_todos():
    fetched_todos = db.session.query(Todo).all()
    return fetched_todos

def fetch_single_todo(todo_id):
    fetched_todos = db.session.query(Todo).filter_by(id=todo_id).first()
    return fetched_todos