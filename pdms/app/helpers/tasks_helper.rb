module TasksHelper
    def getClassNameByTaskStatus(taskStatus)
    taskStatusName = taskStatus.name.downcase
    className = case 
    when taskStatusName.starts_with?('approved')
      'label-success'
    when taskStatusName.starts_with?('submitted for approval')
      'label-info'
    when taskStatusName.starts_with?('revise')
      'label-danger'
    else
      'label-warning'
    end

    "label #{className}"
  end
end
