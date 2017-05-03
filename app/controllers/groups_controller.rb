class GroupsController < ApplicationController
  before_action :authorize_admin!

  def index
  	@groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to groups_path, notice: "Đã tạo nhóm thành công"
    else
      redirect_to groups_path, error: "Đã có lỗi xảy ra, vui lòng thử lại."
    end
  end

  def update
    @group = Group.find_by_id(params[:id])
    @group.assign_attributes group_params

    if @group.save
      redirect_to groups_path, notice: "Đã cập nhật thành công"
    else
      redirect_to groups_path, error: "Đã có lỗi xảy ra, vui lòng thử lại."
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
