class TasksController < ApplicationController
  before_action :search_id, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params['id'])
  end

  def new
    @task = Task.new
  end

  def create
    create_task = Task.new(task_params)
    create_task.save
  end

  def edit
  end

  def update
    @task.update(task_params)
    completed = params['task']['completed'] == '1'
    @task.update(completed: completed)
    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

  def search_id
    @task = Task.find(params['id'])
  end
end
