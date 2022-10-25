require 'rails_helper'

RSpec.describe 'CommentsCreation', type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', password: '123456',
                password_confirmation: '123456')
  end

  let(:article) do
    Article.create(title: 'Test', link: 'link.com', rating: nil, user_id: user.id)
  end

  before do
    sign_in user
  end

  context 'with correct data' do
    it 'creates new comments' do
      expect{
        CommentsCreation.new(['Лучший коммент в мире'], ['The best comment in the world'], article.id).rating
      }.to change(Comment, :count).by(1)
    end

    it 'adds rating to the article' do
      CommentsCreation.new(['Лучший коммент в мире'], ['The best comment in the world'], article.id).rating
      expect(Article.find(article.id).rating).not_to be_nil
    end
  end
end