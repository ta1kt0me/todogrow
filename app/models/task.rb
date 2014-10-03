class Task < ActiveRecord::Base
  belongs_to :user

  validates :name, length: {maximum: 150}, presence: true
end
