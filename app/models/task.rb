class Task < ActiveRecord::Base
  belongs_to :users

  validates :name, length: {maximum: 150}, presence: true
end
