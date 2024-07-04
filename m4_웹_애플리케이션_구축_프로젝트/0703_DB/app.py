from flask import Flask, render_template, request, redirect, url_for, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_wtf import FlaskForm
from flask_wtf.csrf import CSRFProtect
from wtforms import StringField, SubmitField, TextAreaField, DateField
from wtforms.validators import DataRequired
from datetime import datetime
import pytz


app = Flask(__name__)
app.config.from_pyfile('config.py')

db = SQLAlchemy(app)
migrate = Migrate(app, db)
csrf = CSRFProtect(app)

class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)  #스트링은 길이제한
    contents = db.Column(db.Text, nullable=True)  #텍스트는 길이제한 없음
    # imput_date = db.Column(db.DateTime, nullable=False, default=datetime.now(pytz.timezone('Asia/Seoul')))
    input_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    due_date = db.Column(db.DateTime, nullable=False)

class TaskForm(FlaskForm):
    title = StringField('제목', validators=[DataRequired()])
    contents = TextAreaField('내용', validators=[DataRequired()])
    due_date = DateField('마감일', format='%Y-%m-%d', validators=[DataRequired()])
    #인풋 데이트는 시스템 꺼 가져와서 안씀
    
# @app.route('/', methods=['GET', 'POST'])
@app.route('/')  #앱 실행시 처음 뜨는 부분
def index():
    form = TaskForm()
    csrf_token = form.csrf_token._value() #토큰 발행, 공격차단
    # if form.validate_on_submit():
    #     new_task = Task(title=form.title.data)
    #     db.session.add(new_task)
    #     db.session.commit()
    #     return redirect(url_for('index'))  #인덱스 뷰 함수를 호출
    return render_template('index.html', form=form, csrf_token=csrf_token)

@app.route('/tasks')
def tasks():
    tasks = Task.query.all()  #"Task 테이블"에 있는 모든 데이터를 가져옴
    return jsonify(
        [
            {
                'id': task.id, 
                'title': task.title,
                'contents': task.contents,
                'input_date': task.input_date.strftime('%Y-%m-%d'),
                'due_date': task.due_date.strftime('%Y-%m-%d'),
            } 
                for task in tasks
        ]
    )

@app.route('/', methods=['POST'])
def add_task():
    form = TaskForm()
    if form.validate_on_submit():
        title = form.title.data
        contents = form.contents.data

        kst = pytz.timezone('Asia/Seoul')
        input_date = datetime.now(kst).date()

        due_date = form.due_date.data

        new_task = Task(
            title=title, contents=contents, input_date=input_date, due_date=due_date
            )

        db.session.add(new_task)
        db.session.commit()
        return redirect(url_for('index'))
    csrf_token = form.csrf_token._value()
    return render_template('index.html', form=form, csrf_token=csrf_token)

@app.route('/edit/<int:task_id>', methods=['GET', 'POST'])
def edit(task_id):
    task = Task.query.get_or_404(task_id)
    form = TaskForm(obj=task) #태스크 객체 초기화, 폼에 불러온 정보 채워넣음
    if request.method == "POST" and form.validate_on_submit():
        task.title = form.title.data
        task.contents = form.contents.data
        task.due_date = form.due_date.data

        db.session.commit()
        return redirect(url_for('index'))
    csrf_token = form.csrf_token._value()
    #포스트 아니고 제출 통과 못하면 현재 데이터 보여줌
    return render_template(  
        'edit_task.html', 
        form=form,
        task_id=task_id,
        csrf_token=csrf_token, 
        task_title=task.title,
        task_contents=task.contents,
        task_input_date=task.input_date.strftime('%Y-%m-%d'),
        task_due_date=task.due_date.strftime('%Y-%m-%d'),
        )

@app.route('/delete/<int:task_id>')
def delete(task_id):
    task = Task.query.get_or_404(task_id)
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    with app.app_context():  #앱의 정보를 가져옴
        db.create_all()     #디비 초기화 안했는데 만들어지면서 초기화됨, 있으면 있는걸로 처리
    app.run(debug=True)