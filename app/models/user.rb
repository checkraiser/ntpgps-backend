class User < ApplicationRecord
  has_secure_password

  has_many :check_ins
  has_many :check_outs
  has_many :locations
end
