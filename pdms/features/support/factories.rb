FactoryGirl.define do
  
  factory :project_manager_role, class: Role do
    id 2
    name "Project Manager"
  end

  factory :member_role, class: Role do
    id 3
    name "Team Member"
  end

  factory :project_manager, class: User do
    email "pm_cucumber_test@ait.asia"
    firstName "Cucumber"
    lastName "ProjectManager"
    password "password"
    password_confirmation "password"
    association :role, factory: :project_manager_role
  end

  factory :team_member, class: User do
    email "tmm_cucumber_test@ait.asia"
    firstName "Cucumber"
    lastName "TeamMember"
    password "password"
    password_confirmation "password"
    association :role, factory: :member_role
  end

  factory :project, class: Project do
    id 1
    name "Test Project in Cucumber"
    description "This is a test project in Cucumber test"
    pm "Cucumber Test"
  end
end