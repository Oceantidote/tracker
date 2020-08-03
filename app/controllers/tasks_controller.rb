class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :uncomplete, :complete]
  before_action :set_list, only: [:create]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  def complete
    @task.update(completed: true, completed_at: Time.now)
    respond_to do |format|
      format.html { redirect_to project_lists_path(@task.list.project)}
      # format.js
    end
  end

  def uncomplete
    @task.update(completed: false, completed_at: nil)
    respond_to do |format|
      format.html { redirect_to project_lists_path(@task.list.project)}
      # format.js
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.list = @list
    @tasks = @list.tasks
    if @task.save
      params[:task][:user_ids].reject{|r| r == ""}.each do |id|
        UserTask.create(task: @task, user_id: id.to_i)
      end
      redirect_to project_lists_path(@project)
      flash[:notice] =  'Task was successfully created.'
    else
      redirect_to project_lists_path(@project)
      flash[:notice] =  'Please give your task a name at least'
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_list
    @list = List.find(params[:list_id])
    @project = @list.project
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:list_id, :name, :description, :completed_by, :completed, :length, :price, :user_ids)
  end
end
