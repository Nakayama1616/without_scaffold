class MyThreadsController < ApplicationController
  def index
    @my_threads = MyThread.all
  end

  def new
    @my_thread = MyThread.new
  end

end
