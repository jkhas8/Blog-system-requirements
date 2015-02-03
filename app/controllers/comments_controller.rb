class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:sucess] = "Da tao thanh cong"
      redirect_to entry_path(@comment.entry)
    else
      redirect_to request.referrer || root_path
    end
  end

  def destroy

  end

  private
    def comment_params
      params.require(:comment).permit(:content, :entry_id)
    end
end
