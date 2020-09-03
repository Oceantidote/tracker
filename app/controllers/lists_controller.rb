class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create]
  # GET /lists
  # GET /lists.json
  def index

    @project = Project.find(params[:project_id])
    @lists = ordered_lists
    params[:task] ? @task = Task.find(params[:task]) : @task = Task.new
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @lists = [@list]
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    @project = @list.project
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    @list.project = @project
    if @list.save
      redirect_to project_lists_path(@project, @list)
      flash[:notice] = 'List was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def ordered_lists
      list = List.includes({tasks: [{ users: :photo_attachment },:user_tasks, { periods: {user: :photo_attachment} }, { notes: :rich_text_content }]}, { project: { team_memberships: { user: :photo_attachment }}}).where(project: @project)
      quoted = list.where(payment_type: 'quoted')
      support = list.where(payment_type: 'support')
      free = list.where(payment_type: 'my_tasks')
      emergency = list.where(payment_type: 'emergency')
      if !current_user.accepts_promise
        [free, quoted, support, emergency]
      elsif emergency.length > 0
        [emergency, quoted, support, free]
      else
        [quoted, support, free, emergency]
      end
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:project_id, :name, :payment_type, :description)
    end
end
