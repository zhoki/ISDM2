class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :member, :assigntaskindex, :createtask, :tasks, :edittask, :status]
  before_filter :authenticate_user!, :except => [:index]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @users = User.all
    @projects = @projects.paginate(:per_page => 5, :page => params[:page])
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

    # check for an existing task for this project and this document template that still remains unapproved.
    approvedStatus = TaskStatus.where "name LIKE '%Approved%'"
    existingUnapprovedTasks = Task.where(project_id: @project.id, document_template_id: doctmpl_id).where.not(task_status: approvedStatus)

    if existingUnapprovedTasks.count > 0
      flash[:alert] = "Error: There is already a task for this document template that are still unapproved."
      redirect_to action: :assigntaskindex
    else
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
  end

  def tasks
    @tasks = Task.where(project_id: @project.id).order('id DESC, task_status_id ASC')
    @taskStatus = TaskStatus.where id: [3, 4]
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

  def respondTask
    taskId = params[:task_id]
    newTaskStatus = TaskStatus.find params[:respondedStatusID]
    remarks = params[:remarks]

    task = Task.find taskId

    if newTaskStatus.id == 3
      task.remarks = ''
      task.task_status = newTaskStatus
      task.save
    elsif newTaskStatus.id == 4
      if remarks.strip.length > 0
        task.remarks = remarks
        task.task_status = newTaskStatus
        task.save
      else
        flash[:alert] = 'Error: remarks cannot be empty if you want to have this task revised.'
      end
    end

    redirect_to action: :tasks
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

    if params[:user_id]
      @user = User.find(params[:user_id])
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

  def status
    @processes = PmbokProcess.all.order 'id ASC'

    latestTaskForEachDocumentTemplate = \
    %Q(SELECT MAX(t.id) id, MAX("assignedOn") assignedOn, MAX(project_id) project_id, created_at, 
              MAX(updated_at) updated_at, MAX(approver_id) approver_id, MAX(assignee_id) assignee_id, 
              MAX(remarks) remarks, document_template_id, MAX(task_status_id) task_status_id
       FROM tasks t
       WHERE project_id = ?
       GROUP BY t.project_id, t.document_template_id, t.created_at
       HAVING t.created_at = (SELECT MAX(created_at) 
                              FROM tasks tt 
                              WHERE tt.project_id = t.project_id AND 
                                    tt.document_template_id = t.document_template_id))

    @tasks = Task.find_by_sql [latestTaskForEachDocumentTemplate, @project.id]
    @templates = DocumentTemplate.all
    @tasksByDocumentTemplate = @tasks.group_by { |t| t.document_template_id }
  end

  def search
    @search_word = params[:search]
    @results = Project.where("name ILIKE ? OR description ILIKE?", "%#{@search_word}%",
                                "%#{@search_word}%")
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
