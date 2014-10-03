class Task < ActiveRecord::Base

  acts_as_taggable
  belongs_to :user
  # has_many :taggings
  # has_many :tags, through: :taggings

  # attr_accessor :have_tags
  # accepts_nested_attributes_for :tags

  validates :name, length: {maximum: 150}, presence: true
end
