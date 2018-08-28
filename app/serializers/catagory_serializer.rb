class CatagorySerializer < ActiveModel::Serializer
  has_many :notes
  attributes :id, :name
end
