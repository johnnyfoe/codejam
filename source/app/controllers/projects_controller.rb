class ProjectsController < ApplicationController
  def index
    if !params[:id].nil?
      @project = Project.find_by_id(params[:id])
      if !@project.nil?
        redirect_to "/projects/view"
      end
    end
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

  def show
    @project = Project.find(params[:id])
  end
  
  def edit
    if !params[:id].nil?
      @project = Project.find(params[:id])
      if @project.nil?
        redirect_to '/projects'
      end
    end
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
