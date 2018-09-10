class Reference < ApplicationRecord
    has_many :reference_category
    has_many :categories, through: :reference_category
    accepts_nested_attributes_for :categories
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

    def add_categories(category_ids)
        category_ids.each{ |id| self.categories << Category.find(id)} 
        self.save
        self
    end

    def add_new_categories(category_names)
        category_names.each{ |name| self.categories << Category.create({name: name})}
        self.save
        self
    end 

end
