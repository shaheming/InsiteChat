class FriendShip < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validate :cannot_friend_self
  validates_uniqueness_of :user_id, scop: :friend_id
  def cannot_friend_self
    errors.add(:friend_id, "cannot friend self") unless user_id != friend_id
  end
  
 end
