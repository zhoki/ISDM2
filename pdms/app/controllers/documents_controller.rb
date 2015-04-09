class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @project = Project.find params[:id]
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    @project = Project.find params[:proj_id]
    @doctmpl = DocumentTemplate.find params[:doctmpl_id]

    @formOptions = {action: :create, proj_id: @project.id, doctmpl_id: @doctmpl.id}
  end

  # GET /documents/1/edit
  def edit
    @project = Project.find params[:proj_id]
    @doctmpl = DocumentTemplate.find params[:doctmpl_id]

    @formOptions = {action: :update, proj_id: params[:proj_id], id: params[:id], doctmpl_id: params[:doctmpl_id]}
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.update_attribute('project_id', params[:proj_id])
    @document.update_attribute('document_template_id', params[:doctmpl_id])
    @document.update_attribute('user_id', current_user.id)

    respond_to do |format|
      if @document.save
        format.html { redirect_to controller: :documents, action: :index, id: params[:proj_id] }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to action: :edit, proj_id: params[:proj_id], id: params[:id], doctmpl_id: params[:doctmpl_id] }
        format.json { render :index, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find params[:id]
    @project = Project.find params[:proj_id]
    @document.destroy
    respond_to do |format|
      format.html { redirect_to controller: :documents, action: :index, id: @project.id, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Download Template
  #def download
  #send_file(@document.docFile)
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:project_id, :document_template_id, :docFile, :user_id)
    end
end
