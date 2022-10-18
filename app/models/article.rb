class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :link, presence: true
end