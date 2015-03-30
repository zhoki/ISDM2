class WorkflowsController < ApplicationController
  def set
    @documentTemplate = DocumentTemplate.find params[:doctmpl_id]
    @processes = PmbokProcess.all

    @workflows = PmbokWorkflow.where document_template_id: @documentTemplate.id
    @workflowSettings = @processes.collect { |p| p.id }.zip(@workflows.collect {|w| w.doctype}).to_h
  end

  def update
    documentTemplate = DocumentTemplate.find params[:doctmpl_id]

    PmbokProcess.all.select(:id).collect { |id| id.id }.each do |id|
      _workflow = PmbokWorkflow.where document_template_id: documentTemplate.id, pmbok_process_id: id
      _workflow = if _workflow.count == 1 then _workflow.first else PmbokWorkflow.new end
      
      _pmbokProcess = PmbokProcess.find id
      _doctype = params["proc_#{id}"]

      _workflow.pmbok_process = _pmbokProcess
      _workflow.document_template = documentTemplate
      _workflow.doctype = _doctype

      _workflow.save
    end

    redirect_to controller: "document_templates"
  end
end
