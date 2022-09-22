class CommentsController < ApplicationController
  before_action :set_thread
  before_action :set_comment, only: %i[edit show update destroy]

  def index
    @comment = Comment.where(my_thread_id: params[:my_thread_id])
  end

  def new
    #    render html: '読み込み確認'
    @comment = Comment.new()
  end

  def show
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
    @comment.destroy!
    respond_to do |format|
      format.html{redirect_to my_thread_url(:my_thread_id), notice: "削除"}
      format.json{render json: @comment.errors, status: :unprocessable_entity}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :my_thread_id)
    end

    def set_thread
      @thread = MyThread.find(params[:my_thread_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end