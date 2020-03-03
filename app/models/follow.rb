class Follow < ApplicationRecord
  belongs_to :follower_user, foreign_key: :user_id, class_name: 'User'
  belongs_to :following_user, foreign_key: :follow_id, class_name: 'User'
end
