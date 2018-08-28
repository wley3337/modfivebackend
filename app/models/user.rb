class User < ApplicationRecord
    has_many :notes
    accepts_nested_attributes_for :notes
    validates :username, uniqueness: true 
    has_secure_password
end
