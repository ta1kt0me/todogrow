class User < ActiveRecord::Base

  acts_as_tagger
  has_many :tasks, dependent: :destroy

  def self.create_with_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
      user.name = auth['info']['nickname']
    end
  end

  def owned_tag_list
    self.owned_tags.map do |tag|
      tag.name
    end
  end
end
