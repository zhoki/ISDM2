class EmailNotification < ActionMailer::Base
  default from: "pdms.notification@gmail.com"

  def notify_added_member_to_project user, project
    @user = user
    @project = project

    mail to: @user.email, subject: "[PDMS] You are added into project #{project.name}"
  end

  def notify_new_task user, task, project
    @user = user
    @task = task
    @project = project

    mail to: @user.email, subject: "[PDMS] New task for project #{project.name}"
  end

  def notify_task_submitted_for_approval pm, task, project
    @pm = pm
    @task = task
    @project = project

    mail to: @pm.email, subject: "[PDMS] #{@task.assignee.firstName} #{@task.assignee.lastName} has submitted task ##{@task.id} for approval"
  end

  def notify_task_review_result user, task, project
    @user = user
    @task = task
    @project = project
    mail to: @user.email, subject: "[PDMS] The task ##{task.id} you submitted has been #{ if task.task_status_id == 3 then 'approved' else 'rejected' end }!"
  end
end
