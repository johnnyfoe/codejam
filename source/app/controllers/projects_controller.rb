class ProjectsController < ApplicationController
  def index
    # Haven't found a clean way to do "SELECT * FROM PROJECTS" yet, but that's what this outputs!
    @projectList = Project.where("")
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      # handle a successful save
      flash[:success] = "Successfully created a project on Codej.am!"
      redirect_to '/projects'
    else
      render 'home/index'
    end
  end
  
  def edit
  end

  def contributors
  end

  def skills
  end

  def interests
  end

  def search
  end
end
