class Reference < ApplicationRecord
    has_many :reference_category
    has_many :categories, through: :reference_category

    def serialize
        {reference: self, categories: self.categories.map{|category| {id: category.id, name: category.name}}}
    end

end
