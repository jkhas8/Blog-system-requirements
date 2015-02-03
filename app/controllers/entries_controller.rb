class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Đã tạo bài thành công!"
      redirect_to root_url
    else
      redirect_to '/login'
    end
  end

  def destroy

  end

  def show
    @entry = Entry.find(params[:id])
    @user = @entry.user
    @comment = @entry.comments.build if logged_in?
    @comments = @entry.comments.paginate(page: params[:page])
  end

  private
    def entry_params
      params.require(:entry).permit(:title,:content)
    end
end
