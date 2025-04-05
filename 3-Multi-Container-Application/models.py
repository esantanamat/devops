from db import db
from datetime import datetime
from sqlalchemy.sql import func

class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    task = db.Column(db.Text, nullable=False)
   