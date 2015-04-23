FactoryGirl.define do
  
  # TASK STATUSES

  factory :in_progress_status, class: TaskStatus do
    id 1
    name "In progress"
  end

  factory :submitted_for_approval_status, class: TaskStatus do
    id 2
    name "Submitted for approval"
  end

  factory :approved_status, class: TaskStatus do
    id 3
    name "Approved"
  end 

  factory :revise_status, class: TaskStatus do
    id 4
    name "Revise"
  end

  # USER ROLES

  factory :project_manager_role, class: Role do
    id 2
    name "Project Manager"
  end

  factory :member_role, class: Role do
    id 3
    name "Team Member"
  end

  # USERS

  factory :project_manager, class: User do
    email "pm_cucumber_test@ait.asia"
    firstName "Cucumber"
    lastName "ProjectManager"
    password "password"
    password_confirmation "password"
    association :role, factory: :project_manager_role, strategy: :build
  end

  factory :team_member, class: User do
    email "tmm_cucumber_test@ait.asia"
    firstName "Cucumber"
    lastName "TeamMember"
    password "password"
    password_confirmation "password"
    association :role, factory: :member_role, strategy: :build
  end

  factory :document_template, class: DocumentTemplate do
    name "Cucumber test document template"
    template_file_name "cucumber_test_document_template.docx" 
    template_content_type "application/octet-stream"
  end

  factory :task, class: Task do
    # association :project, factory: :project, strategy: :build
    # association :approver, factory: :project_manager, strategy: :build
    # association :assignee, factory: :team_member, strategy: :build
    association :task_status, factory: :in_progress_status, strategy: :build
    association :document_template, factory: :document_template
    remarks " "
  end

  factory :project, aliases: [:test_project], class: Project do
    id 1
    name "Test Project in Cucumber"
    description "This is a test project in Cucumber test"
    pm "Cucumber ProjectManager"
  end
end