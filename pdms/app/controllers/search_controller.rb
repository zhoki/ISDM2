class SearchController < ApplicationController
  def index
  end

  def result
    @project = params[:name]

    @projects = Project.where('upper(name) like upper(?) and upper(status) like upper(?) and ((?) between startDate and dueDate or (?) between startDate and dueDate or startDate between (?) and (?) or dueDate between (?) and (?))', "%#{params[:name]}%","#{@status}%","#{@dueDate}%", "#{@startDate}%","#{@dueDate}%","#{@startDate}%","#{@dueDate}%")
  end
end

