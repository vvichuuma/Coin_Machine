class User < ApplicationRecord
  
    has_secure_password
  validates :email, presence: true, uniqueness: true

    has_many :coins

    has_many :draws

end
