class Task < ActiveRecord::Base
  validates :name, length: {maximum: 150}, presence: true
end
