class MyThreadsController < ApplicationController
  def index
    @my_threads = Mythread.all
  end

  def new
    @my_thread = MyThread.new
  end

end
