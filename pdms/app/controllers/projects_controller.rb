class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :member, :assigntaskindex, :createtask, :tasks, :edittask]
  before_filter :authenticate_user!, :except => [:index]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @users = User.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.update_attribute('pm', current_user.firstName + " " + current_user.lastName)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def assigntaskindex
    @documents = DocumentTemplate.all
    @pm = User.where('"firstName" || \' \' || "lastName" = ?', @project.pm)
    @teammembers = @project.users
  end

  def createtask
    doctmpl_id = params[:doctmpl_id]
    doctmpl = DocumentTemplate.find doctmpl_id

    remark = params[:remark]

    approver_id = params[:approver_id]
    approver = User.find approver_id

    assignee_id = params[:assignee_id]
    assignee = User.find assignee_id

    currentDate = Date.parse(Time.now.to_s)

    task = Task.new
    task.project = @project
    task.assignedOn = currentDate
    task.approver = approver
    task.assignee = assignee
    task.document_template = doctmpl
    task.remarks = remark

    task.save

    redirect_to action: :tasks
  end

  def tasks
    @tasks = Task.where(project_id: @project.id).order('document_template_id ASC, id ASC')
  end

  def edittask
    @task = Task.find params[:taskid]
    @teammembers = @project.users
  end

  def updatetask
    task = Task.find params[:taskid]
    newAssignee = User.find params[:assignee_id]

    task.assignee = newAssignee
    task.save
    redirect_to action: 'tasks'
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

  # Get /projects/3/member
  def member

    @project_members = Project.find(params[:id]).users

    # @user = User.new
    @project = Project.find(params[:id])
    @user = User.find((params[:user_id].nil?)? params[:id] : params[:user_id])
    if params[:user_id]
      if @project.users << @user and @project.save
        flash[:notice] = 'User was saved.'
      end
    end

    @availableTeamMembers = User.where("role_id=3").where.not(id: (ProjectUser.where(project_id: params[:id]).collect {|_pu| _pu.user_id}))
  end

  def remove_member
    project_member = ProjectUser.where(project_id: params[:id], user_id: params[:userid]).delete_all
    redirect_to :member
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :pm, :startDate, :dueDate, :user_id)
    end
end
