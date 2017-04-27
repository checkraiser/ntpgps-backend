class GroupsController < ApplicationController
  before_action :authorize_admin!

  def index
  	@groups = Group.all
  end

  def new
  end

  def create
  end
end
