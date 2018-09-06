class UserReference < ApplicationRecord
    belongs_to :user 
    belongs_to :reference 
end
