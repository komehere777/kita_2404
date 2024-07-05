from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()  # db 객체 생성, db와 app을 연결

class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    contents = db.Column(db.Text, nullable=False)
    input_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow())
    due_date = db.Column(db.DateTime, nullable=False)