class CategorySerializer < ActiveModel::Serializer
  has_many :notes
  attributes :id, :name

  def notes
    Note.public?
  end 
end
