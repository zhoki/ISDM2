class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.where(firstName: params[:firstName]).first_or_create
    session[:user_id] = user.id
    redirect_to document_templates_path
  end

  def logout
    session[:user_id] = nil
    redirect_to document_templates_path
  end

end
