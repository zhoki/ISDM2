class DocumentHistoriesController < ApplicationController
  before_action :set_document_history, only: [:show, :edit, :update, :destroy]

  # GET /document_histories
  # GET /document_histories.json
  def index
    @document_histories = DocumentHistory.all
  end

  # GET /document_histories/1
  # GET /document_histories/1.json
  def show
  end

  # GET /document_histories/new
  def new
    @document_history = DocumentHistory.new
  end

  # GET /document_histories/1/edit
  def edit
  end

  # POST /document_histories
  # POST /document_histories.json
  def create
    @document_history = DocumentHistory.new(document_history_params)
    @document_history.update_attribute('uploadedBy', current_user.firstName + " " + current_user.lastName)

    respond_to do |format|
      if @document_history.save
        format.html { redirect_to @document_history, notice: 'Document history was successfully created.' }
        format.json { render :show, status: :created, location: @document_history }
      else
        format.html { render :new }
        format.json { render json: @document_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_histories/1
  # PATCH/PUT /document_histories/1.json
  def update
    respond_to do |format|
      if @document_history.update(document_history_params)
        format.html { redirect_to @document_history, notice: 'Document history was successfully updated.' }
        format.json { render :show, status: :ok, location: @document_history }
      else
        format.html { render :edit }
        format.json { render json: @document_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_histories/1
  # DELETE /document_histories/1.json
  def destroy
    @document_history.destroy
    respond_to do |format|
      format.html { redirect_to document_histories_url, notice: 'Document history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_history
      @document_history = DocumentHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_history_params
      params.require(:document_history).permit(:uploadedBy, :versionNumber, :checksum, :document_template_id)
    end
end
