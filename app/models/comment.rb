class Comment < ApplicationRecord
  belongs_to :todo
  validates :todo_id, presence: true
end
