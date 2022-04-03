class TasksController < ApplicationController
    before_action :project_id, only: [:create, :edit, :update, :show]
    before_action :set_id, only: [:edit, :update, :destroy, :show]
    #Create task for creating a new task 
    def create 
        @task = @project.tasks.build(tasks_params)
        if @task.save
            flash[:notice] = "Task successfullyy created!"
            redirect_to project_path(@project)
        else 
            flash[:alert] = "Tasks has not been created"
            render 'project/show'
        end
    end
    #Leave edit empty 
    def edit 
    end
        
    #Update function to update created tasks and save them 
    def update 
        respond_to do |f|
            if @task.update(tasks_params)
                f.html{ redirect_to([@task.project, @task], notice: 'Task was successfully Updated')}
            else
                render action: 'edit'
            end
        end
    end

    #Leave empty 
    def show 
    end

    #Destroy function to remove the Task from the db
    def destroy
        @task.destroy
        respond_to do |format|
            format.turbo_stream {render turbo_stream: turbo_stream.remove(@task)}
            format.html { redirect_to project_path(@project)}
        end
    end

    private 

    def set_id 
        @task = Task.find(params[:id])
    end

    def project_id
        @project = Project.where(id:params[:project_id]).first
    end
    
    def tasks_params
        params.required(:task).permit(:body, :status, user_ids: []) # Use user Id's and point to the array 
    end
end
