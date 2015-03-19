json.array!(@document_histories) do |document_history|
  json.extract! document_history, :id, :uploadedBy, :versionNumber, :checksum
  json.url document_history_url(document_history, format: :json)
end
