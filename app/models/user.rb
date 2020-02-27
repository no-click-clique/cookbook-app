class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, length: { maximum: 20 }
  validates :password, length: { in: 6..20 }

  has_many :recipes
end
