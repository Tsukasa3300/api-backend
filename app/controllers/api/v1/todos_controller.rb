class Api::V1::TodosController < ApplicationController

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
    @todo.destroy
    flash[:success] = "削除しました"
    if request.referrer.nil?
      redirect_to request.referrer, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end
  
  private

  def todo_params
    params.require(:todo).permit(:content)
  end


  include SessionHelper
    def logged_in_user
        unless logged_in?
            render json: { error: 2 }, status: :unauthorized
        end
    end
end