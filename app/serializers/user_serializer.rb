class UserSerializer < ActiveModel::Serializer
  has_many :notes
  attributes :id, :username, :first_name, :last_name, :roll, :start_date

  # def notes
  #   Note.mine? this should return all of the users notes may not need this
  # end 
end
