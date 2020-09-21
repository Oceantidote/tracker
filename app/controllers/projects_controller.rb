class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :team_memberships]

  # GET /projects
  # GET /projects.json

  def index
    @projects = policy_scope(Project)
  end

  def team_memberships
    @memberships = @project.team_memberships
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    authorize @project
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    authorize @project
    project_params[:dev_user_id] ? @project.user = current_user : @project.dev_user = current_user
    respond_to do |format|
      if @project.save
        TeamMembership.create!(user: @project.user, relation: "client", project: @project)
        TeamMembership.create!(user: @project.dev_user, relation: "lead", project: @project)
        Invoice.create!(project: @project)
        Chatroom.create!(name: @project.name, project: @project)
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.includes(team_memberships: [user: [photo_attachment: :blob]], lists: [:tasks]).find(params[:id])
      authorize @project
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:user_id, :dev_user_id, :name)
    end
end
