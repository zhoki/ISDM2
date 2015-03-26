json.array!(@documents) do |document|
  json.extract! document, :id, :title, :user_id, :file, :document_template_id
  json.url document_url(document, format: :json)
end
