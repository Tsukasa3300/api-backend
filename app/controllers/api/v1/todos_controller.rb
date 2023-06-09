class Api::V1::TodosController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create]

  def index
    todos = Todo.order(updated_at: :desc)
    render json: todos
  end
  
  def show
    todo = Todo.find(params[:id])
    render json: todo
  end
  
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo
    else
      render json: todo.errors.errors.full_messages, status: 422
    end
  end
  
  def update
    todo = Todo.find(params[:id])
    if todo.update(todo_params)
      render json: todo
    else
      render json: todo.errors, status: 422
    end
  end
  
  def destroy
    if Todo.destroy(params[:id])
      head :no_content
    else
      render json: { error: "Failed to destroy" }, status: 422
    end
  end
  
  private

  def todo_params
    params.require(:todo).permit(:content)
  end


end