class User < ActiveRecord::Base
  has_many :ideas
  has_many :likes

  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :name, :alias, :email, :password, presence: true
end
