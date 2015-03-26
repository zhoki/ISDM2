class VersionsController < ApplicationController
  before_action :require_user
  before_action :set_document_template_and_version, only: [:diff, :rollback, :destroy]

  def diff
  end

  def rollback
    # change the current document template to the specified version
    # reify gives you the object of this version
    document_template = @version.reify
    document_template.save
    redirect_to edit_document_template_path(document_template)
  end

  private

  def set_document_template_and_version
    @document_template = DocumentTemplate.find(params[:document_template_id])
    @version = @document_template.versions.find(params[:id])
  end

end


