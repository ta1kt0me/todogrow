class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
      user.name = auth['info']['nickname']
    end
  end
end
