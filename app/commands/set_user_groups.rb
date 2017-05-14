class SetUserGroups
  prepend SimpleCommand

  def initialize(user, group_ids)
  	@user = user
  	@group_ids = group_ids
  end

  def call
  	set_user_groups
  end

  private

  attr_accessor :user, :group_ids

  def set_user_groups
  	exist_group_ids = Group.where(id: group_ids).pluck(:id)
    user_group_ids = user.groups.pluck(:id)
    removed_group_ids = user_group_ids - exist_group_ids
    added_group_ids = exist_group_ids - user_group_ids
    ActiveRecord::Base.transaction do 
      UserGroup.where(group_id: removed_group_ids).delete_all
      unless added_group_ids.empty?
        added_group_ids.each do |gid|
          UserGroup.create(user_id: user.id, group_id: gid)
        end
      end
    end
    Report.refresh
    user.reload
  rescue => e
  	errors.add :set_user_groups, e.message
  end
end