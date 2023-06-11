class Api::V1::CommentsController < ApplicationController
  # 注意
  def index
    comments = Comment.where(todo_id: params[:todo_id])
    render json: comments
  end
  # 
  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    @todo = Todo.find(params[:todo_id])
    @comment = @todo.comments.build(comment_params)
    if @comment.save
      redirect_to request.referrer
    else
      flash[:danger] = "項目を埋めてください"
      redirect_to request.referrer, status: :see_other
    end
  end 
        
  def destroy
    @comment.destroy
    if request.referrer.nil?
      flash[:success] = "記録を削除しました"
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

          
  def comment_params
    params.require(:comment).permit(:content, :todo_id)
  end
      
end
