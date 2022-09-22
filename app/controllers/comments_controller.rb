class CommentsController < ApplicationController
  before_action :set_thread

  def index

  end

  def new
    #    render html: '読み込み確認'
    @comment = Comment.new()
  end

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html{redirect_to my_thread_url(params[:my_thread_id])}
        format.json{render :show, status: :created, location: @comment}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }

      end
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def comment_params
      params.require(:comment).permit(:body, :my_thread_id)
    end

    def set_thread
      @thread = MyThread.find(params[:my_thread_id])
    end
end