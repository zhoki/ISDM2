class SearchController < ApplicationController
  def index
  end

  def result
    @project = params[:name]

    @projects = Project.where('upper(name) like upper(?)', "%#{params[:name]}%")
  end
end
