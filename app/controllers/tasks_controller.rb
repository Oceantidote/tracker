class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :uncomplete, :complete]
  before_action :set_list, only: [:create]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = policy_scope(Task)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    authorize @task
  end

  # GET /tasks/1/edit
  def edit
  end

  def complete
    @task.update(completed: true, completed_at: Time.now, invoice: @task.list.project.current_invoice)
    respond_to do |format|
      format.html { redirect_to project_lists_path(@task.list.project)}
      # format.js
    end
  end

  def uncomplete
    @task.update(completed: false, completed_at: nil, invoice: nil)
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
    do_quote_stuff if @quote
    authorize @task
    @tasks = @list.tasks
    if @task.save
      params[:task][:user_ids].reject{|r| r == ""}.each do |id|
        UserTask.create(task: @task, user_id: id.to_i)
      end
      if @quote
        redirect_to quote_path(@quote)
      else
        redirect_to project_lists_path(@project)
      end
      flash[:notice] =  'Task was successfully created.'
    else
      if @quote
        render "quotes/show"
      else
        redirect_to project_lists_path(@project)
      end
      flash[:notice] =  'Please give your task a name'
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

  def do_quote_stuff
    @task.quote = @quote
    @task.price = @task.length / 60.0 * 4000
  end

  def set_list
    if params[:quote_id]
      @quote = Quote.find(params[:quote_id])
      @list = @quote.list
    else
      @list = List.find(params[:list_id])
    end
    @project = @list.project
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
    authorize @task
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:list_id, :name, :description, :completed_by, :completed, :length, :price, :user_ids)
  end
end
