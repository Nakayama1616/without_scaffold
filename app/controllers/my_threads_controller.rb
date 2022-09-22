# TODO:質問リスト
# 1,データのIDがnilの理由
#
class MyThreadsController < ApplicationController
  # 各メソッドの読み込み前に実行される　before_action
  # set_my_threadをshowのみで動くように制限
  # before_action :set_my_thread, only: %i[show, edit, update]
  # onlyの後の関数の羅列に「,」は不要
  before_action :set_my_thread, only: %i[show edit update destroy]

  def index
    @my_threads = MyThread.all
  end

  def new
    @my_thread = MyThread.new
  end

  # before_actionでset_my_threadを読み込んでいるよ！
  def show
  end

  def edit
  end

  def create
    @my_thread = MyThread.new(my_thread_params)
    respond_to do |format|
      if @my_thread.save
        format.html { redirect_to my_thread_url(@my_thread), notice: "登録完了" }
        # TODO　「:created」や「:ok」（updateで使用）などについて詳しくしらべる
        format.json { render :show, status: :created, location: @my_thread }
      else
        # リクエストされるフォーマットがHTML形式の場合
        format.html { render :new, status: :unprocessable_entity }
        # リクエストされるフォーマットがJSON形式の場合
        # @my_thread.errorsをJSON形式で返す
        format.json { render json: @my_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      # すでにset_my_threadで更新するデータを@my_threadで定義しているので下記のIF文は間違え
      # if @my_thread = MyThread.update(my_thread_params)
      if @my_thread.update(my_thread_params)
        format.html { redirect_to my_thread_url(@my_thread), notice: "更新完了" }
        format.json { render :show, status: :ok, location: @my_thread }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @my_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # destroyとdeleteの違い　https://qiita.com/jackie0922youhei/items/588cd6f62cb1ff9e9809
    @my_thread.destroy!
      respond_to do |format|
        format.html{redirect_to my_threads_url, notice: "削除"}
        format.json
      end
  end

  private
  # 一部の関数で使用されているデータを読み込む用の関数
    def set_my_thread
      @my_thread = MyThread.find(params[:id])
    end

    def my_thread_params
      # トークンがあるから確認できないが「curl -X POST 'http://localhost:3000/my_threads' -H "Content-Type: application/json" -d '{"my_thread":{"tittle":"a","body":"b"}}'」
      # 上記のPOST内容の時にタイトルとボディーが返る
      params.require(:my_thread).permit(:tittle,:body)
    end
end
