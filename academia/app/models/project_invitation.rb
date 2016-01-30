class ProjectInvitation < ActiveRecord::Base

  def from
    User.find(self.from_user)
  end

  def to
    User.find(self.to_user)
  end

  def project
    Project.find(self.project_id)
  end

end
