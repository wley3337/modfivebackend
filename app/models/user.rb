class User < ApplicationRecord
    has_many :notes
    accepts_nested_attributes_for :notes
    validates :username, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true  
    has_secure_password
end
