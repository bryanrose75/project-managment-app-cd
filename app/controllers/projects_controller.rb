class ProjectsController < ApplicationController
  #initiate the functions 
  before_action :set_id, only: [:edit, :update, :show, :destroy]


  def index
    @projects = Project.all
    @project = Project.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "Project was created "}
      else 
        format.html { render :new, status: :unprocessable_entity } #Have an error if there is an empty record 
      end
    end
  end

  def edit
  end

  def show 
    @task = @project.tasks.build
    @tasks = @project.tasks
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html{ redirect_to project_path, notice: "Successfully Updated Project!"}
        else #format the turbo stream 
          format.turbo_stream{ #render and replace the turbo stream, use the project form 
            render turbo_stream: turbo_stream.replace(@project, partial: "projects/form", locals: {project: @project}) } #Have an error if there is an empty record 
          format.html {render :new}
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted"
  end
  
  private

  def set_id 
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:content, :vote)
  end
end