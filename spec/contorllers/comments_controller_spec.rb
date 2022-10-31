require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', password: '123456',
                password_confirmation: '123456')
  end

  let(:article) do
    Article.create(title: 'Test', link: 'link.com', rating: nil, user_id: user.id)
  end

  let(:comment) do
    Comment.create(text: 'This is test comment', rating: 99.5, article_id: article.id)
  end

  before do
    sign_in user
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: comment.id }
      expect(response).to render_template(:show)
    end
  end

  describe "POST create" do
    context 'with correct params' do
      it "creates new comments and rating" do
        expect{
          post :create, params: { comment: { original_comments: ['Лучший коммент в мире'], translated_comments: ['The best comment in the world'], article_id: article.id } }
        }.to change(Comment, :count).by(1)
        expect(Article.find(comment.article_id).rating).not_to be_nil
      end
    end

    context 'with incorrect params' do
      it "renders the new template" do
        expect{
          post :create, params: { comment: { original_comments: ['Лучший коммент в мире'], translated_comments: ['The best comment in the world'], article_id: nil } }
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end