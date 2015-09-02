class Wiki < ActiveRecord::Base
  belongs_to :user
  

  #scope :visible_to, -> (user) { user ? all : where(public: true) }
  #scope :visible_to, -> (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? all : all_public  }

  scope :all_public, -> { where(private: [nil, false]) }
  #scope :my_private, -> (user) { where(private: true, user_id: user.id )}

  def self.visible_to(user)
    if user && (user.role == 'premium')
      # where user_id: user.id OR all_public
      #all_public + my_private(user)
      where("user_id = ? OR  private = 'f' OR private IS NULL", user.id)
    elsif user && (user.role == 'admin')
      all
    else
      all_public
    end
  end
end
