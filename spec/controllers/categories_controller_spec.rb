require 'rails_helper'

describe CategoriesController, type: :controller do
    before(:context) do 
        @test_category = Category.create(name: "Test Category")
        @user1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")
        @n1 = Note.create(note_content: "Test Note", user: @user1, public_note: false)
        @n2 = Note.create(note_content: "Test Note", user: @user1, public_note: true)
        @test_category.notes << @n1
        @test_category.notes << @n2 

        
    end 
    
    after(:context) do
        Category.destroy_all
        User.destroy_all
        Note.destroy_all
    end 


    it 'returns status of 401 when user not logged in' do
        get(:index)
        expect(response.status).to eq(401)
    end 

    #Brittle test if records aren't deleated correctly with destroy_all 
    it 'returns all categories with logged in user' do 
        # mocks authenticate for controller
        allow(controller).to receive(:authenticate).and_return(@user1)
        get(:index)

        expect(JSON.parse(response.body)[0]['name']).to eq('Test Category')
       
    end 

end
