class Reference < ApplicationRecord
    has_many :reference_category
    has_many :categories, through: :reference_category
    validates :link, uniqueness: true, presence: true
    validates :title, presence: true

    def serialize_reference
        {reference: self, categories: self.categories.map{|category| {id: category.id, name: category.name}}}
    end

    def self.reference_set(starting_id)
        Reference.where(" id > ?", starting_id).limit(300).map{|reference| reference.serialize_reference}
    end

    def self.references_by_category(category_id)
        searchCategory = Category.find(category_id)
        searchCategory.references
    end 

end
