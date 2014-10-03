class Task < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user

  validates :name, length: {maximum: 150}, presence: true
end
