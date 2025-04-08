from flask import Blueprint, redirect, request, jsonify
from app.db import db
from app.functions import fetch_all_todos, fetch_single_todo 
from app.models import Todo
routes = Blueprint("routes", __name__)


@app.route('/')
def hello_world():
    return 'Hello, World!'
@routes.route('/todos', methods=['GET', 'POST'])
def get_todos(): 
    
    if request.method == 'GET':
        all_todos = fetch_all_todos()
        result = []
        for todo in all_todos:
            result.append({
                'id': todo.id,
                'task': todo.task
            })
        return jsonify(result), 200
    if request.method == 'POST': 
        data = request.get_json()
        new_task = data.get('task')
        new_id = data.get('id')
        new_commit = Todo(task = new_task,id = new_id)
        db.session.add(new_commit)
        db.session.commit()
        return jsonify({"task": new_task}), 201


@routes.route('/todos/<id>', methods=['PUT', 'GET', 'DELETE'])
def handle_shorten_by_id(id):
    todo_by_id = fetch_single_todo(id)
    if not todo_by_id:
        return jsonify({'message': 'the to do with that id does not exist'}), 400
    if request.method == 'GET':
        return jsonify({
            'id': todo_by_id.id,
            'task': todo_by_id.task,
        }), 200
    if request.method == 'PUT':
        data = request.get_json()
        new_task = data.get('task')
        if not new_task:
            return jsonify({'error': 'New task is required'}), 400
        todo_by_id.task = new_task
        db.session.commit()
        return jsonify({
            'message': f'the task has been updated to {new_task}'
        })
    if request.method == 'DELETE':
        db.session.delete(todo_by_id)
        db.session.commit()
        return jsonify({'message': 'The task has been deleted'
        }), 200