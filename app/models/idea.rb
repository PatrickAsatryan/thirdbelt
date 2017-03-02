class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { minimum: 15 }
end
