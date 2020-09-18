class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index, :show, :new, :create]

  def index
    @documents = policy_scope(Document.where(project: @project))
  end

  def show
  end

  def new
    @document = Document.new
    authorize @document
  end

  def create
    @document = Document.new(document_params)
    authorize @document
    @document.project = @project
    if @document.save
      redirect_to document_path(@document)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to document_path(@document)
    else
      render :edit
    end
  end

  def destroy
    @document.delete
    redirect_to project_path(@document.project)
  end

  private

  def set_document
    @document = Document.find(params[:id])
    authorize @document
  end

  def set_project
    if params[:project_id]
      @project = Project.find(params[:project_id])
    else
      @project = @document.project
    end

  end

  def document_params
    params.require(:document).permit(:name, :url, :file)
  end
end
