require 'rails_helper'

describe Reference, type: :model do

    before(:context) do 
        @test_category_1 = Category.create(name: "Test Category 1")
        @test_category_2 = Category.create(name: "Test Category 2")
        @user1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")
        @r1 = Reference.create(title: "test ref 1", link: "https://testing1.html")
        @r2 = Reference.create(title: "test ref 2", link: "https://testing2.html")

        @test_category_1.references << @r1
        @test_category_1.references << @r2

        @test_category_2.references << @r2 

    
    end 

    after(:context) do
        Category.destroy_all
        User.destroy_all
        Reference.destroy_all
    end
    
    context '#serialize_reference' do 
        it 'returns properly serialized reference' do
            correctly_ser_ref = {reference: @r2, categories: [{id: @test_category_1.id, name: @test_category_1.name}, {id: @test_category_2.id, name: @test_category_2.name}]}
            expect(@r2.serialize_reference).to eq(correctly_ser_ref)
        end
    end

    context '.references_by_category' do 
        it 'only returns references in a category given category id' do 
            expect(Reference.references_by_category(@test_category_1.id).length).to eq(2)
            expect(Reference.references_by_category(@test_category_2.id).length).to eq(1)
        end 
    end

    context '#add_categories' do 
        it 'correctly adds an existing category to an existing reference' do 
            expect(@r1.categories.length).to eq(1)
            @r1.add_categories([@test_category_2.id])
            expect(@r1.categories).to include(@test_category_2)
        end

        it 'returns the updated reference' do 
            new_cat = Category.create(name: "Third Test Cat")
            returned_updated_ref = @r2.add_categories([new_cat.id])

            expect(returned_updated_ref).to be(@r2)
        end 
    end 

    context '#add_new_categories' do 
        it 'creates and adds a category by name an existing reference' do 
            num = Category.all.length
            @r1.add_new_categories(["new test category"])
            expect(Category.all.length).to eq(num + 1 )
            expect(@r1.categories.last.name).to eq("new test category")
        end 

        it 'returns the updated reference' do 
            returned_updated_ref = @r2.add_new_categories(["brand new cat"])
            expect(returned_updated_ref).to be(@r2)
        end 
    end 

    context '.reference_set' do
        before do 
            @marker_ref = Reference.create(title: "marker ref", link: "https://marker/ref.html")
            i=0
            50.times do 
                Reference.create(title: " #{i}", link: "https://#{i}.html")
                i += 1
            end
            @over_ref = Reference.create(title: "over_ref", link: "https://over/ref.html")
        end 

        after do 
            Category.destroy_all
            User.destroy_all
            Reference.destroy_all
        end 

        it 'returns only 50 items' do 
            test_set = Reference.reference_set(@marker_ref.id)
            expect(test_set.length).to eq(50)
            expect(test_set).not_to include(@over_ref)
        end

        it 'begins at correct id non-inclusive' do 
            test_set = Reference.reference_set(@marker_ref.id)
            expect(test_set).not_to include(@marker_ref)
            expect(test_set.first[:reference].id).to eq(@marker_ref.id + 1)
        end
    end

end