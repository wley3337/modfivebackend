class UserSerializer < ActiveModel::Serializer
  has_many :notes
  attributes :id, :username, :first_name, :last_name, :roll, :start_date
end
