class Relationship < ApplicationRecord
  belongs_to :following, class_name: 'User'
  belongs_to :follower, class_name: 'User'
  # followigやfollowerはフォローする人とーされる人を区別するためのものなので、userテーブルを参照する必要あり
end
