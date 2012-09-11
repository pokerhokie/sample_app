# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  validates(:user_id, { presence: true } )
  validates(:content, { presence: true, length: { maximum: 140, minimum: 1 } } )
  
  belongs_to :user;
  
  default_scope order: 'microposts.created_at DESC'
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id from relationships where follower_id = :user_id"
    
    Micropost.where("user_id in (#{followed_user_ids}) or user_id = :user_id", user_id: user)
    #Micropost.where("user_id in (?) or user_id = ?", user.followed_ids, user.id)
    
    #This also works
    #Micropost.where("user_id in (?) or user_id = ?", user.followeds.map(&:id), user.id)
  end
  
end
