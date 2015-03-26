json.array!(@tasks) do |task|
  json.extract! task, :id, :assignedOn, :project_id, :document_id, :approver, :assignnee, :status
  json.url task_url(task, format: :json)
end
