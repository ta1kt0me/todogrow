require 'rails_helper'

describe User, :type => :model do
  context '外部連携ログインするとき' do
    before do
      @auth = {'provider' => 'twitter', 'uid' => '1', 'info' => {'nickname' => 'ta1kt0m'}}
      @login_user = User.create_with_omniauth(@auth)
    end
    it '未登録ユーザーがログインできること' do
      expect(@login_user.provider).to eq @auth['provider']
      expect(@login_user.uid).to eq @auth['uid']
      expect(@login_user.name).to eq @auth['info']['nickname']
    end

    let(:user) {
      User.create(provider: @auth['provider'], uid: @auth['uid'], name: @auth['info']['nickname'])
    }
    it '登録済みユーザーがログインできること' do
      expect(@login_user.provider).to eq user.provider
      expect(@login_user.uid).to eq user.uid
      expect(@login_user.name).to eq user.name
    end
  end

  context 'タグを取得するとき' do
    it 'タグ情報がないこと' {}
    it 'タグ情報が1件' {}
    it 'タグ情報が2件' {}
  end

end
