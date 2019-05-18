class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  PER = 5

  def index
    @tasks = current_user.tasks
    @sorted_tasks = @tasks.sort_tasks(params)
    @searched_tasks = @sorted_tasks.search_tasks(params)
    @finally_tasks = @searched_tasks.page(params[:page]).per(PER)
    @task = Task.new
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を登録しました！"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク「#{@task.name}」を削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :status, :priority, label_ids: [])
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
