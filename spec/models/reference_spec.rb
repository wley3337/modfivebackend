# require 'rails_helper'

# describe Reference, type: :model do

#     before(:context) do 
#         @test_category_1 = Category.create(name: "Test Category 1")
#         @test_category_2 = Category.create(name: "Test Category 2")
#         @user1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")
#         @n1 = Note.create(note_content: "Test Note", user: @user1, public_note: false)
#         @n2 = Note.create(note_content: "Test Note", user: @user1, public_note: true)
    
#         @test_category_1.notes << @n1
#         @test_category_2.notes << @n2 
#     end 

#     after(:context) do
#         Category.destroy_all
#         User.destroy_all
#         Note.destroy_all
#     end

# end