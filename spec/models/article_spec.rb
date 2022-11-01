require 'rails_helper'

RSpec.describe Article, type: :model do
  subject(:article) do
    described_class.new(title: 'Anything', link: 'test.com',
                        rating: 95.5, user_id: user.id)
  end

  let(:user) do
    User.create(email: 't@t.com', password: '123456',
                password_confirmation: '123456')
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      puts user.inspect
      expect(article).to be_valid
    end

    it 'is not valid without a link' do
      article.link = nil
      expect(article).not_to be_valid
    end
  end
end
