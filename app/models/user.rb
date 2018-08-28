class User < ApplicationRecord
    has_many :notes
    accepts_nested_attributes_for :notes
    validates :username, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true  
    has_secure_password

    # creates a serialized version of user for json token response
    def serialize_user
        {id: self.id, username: self.username, firstName: self.first_name, lastName: self.last_name, roll: self.roll, startDate: self.start_date, notes: self.notes}
    end
end
