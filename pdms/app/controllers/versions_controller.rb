class VersionsController < ApplicationController
  #before_action :require_user
  before_action :set_document_and_version, only: [:diff, :rollback, :destroy]

  def diff
  end

  def rollback
    # change the current document template to the specified version
    # reify gives you the object of this version
    document = @version.reify
    document.save
    #redirect_to edit_document_path(document)
    redirect_to indexdocument_path
  end

  private

  def set_document_and_version
    @document = Document.find(params[:document_id])
    @version = @document.versions.find(params[:id])
  end

end


