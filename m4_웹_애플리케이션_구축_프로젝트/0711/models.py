from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

#관계형 데이터베이스를 사용하기 위한 객체 생성
#각 다른 데이터베이스를 사용할 수 있음
db = SQLAlchemy()  # db 객체 생성, db와 app을 연결

#Task 테이블 생성
class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    contents = db.Column(db.Text, nullable=False)
    input_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow())
    due_date = db.Column(db.DateTime, nullable=False)
    
#유저관리가 필요한 경우라 User 테이블을 생성
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)
    is_admin = db.Column(db.Boolean, default=False)
