class NoteSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :catagories
  attributes :id, :note_content, :public_note, :user_id
end
