require 'rails_helper'

describe Category, type: :model do

  before(:context) do 
      @test_category = Category.create(name: "Test Category")
      @user1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")
      @n1 = Note.create(note_content: "Test Note", user: @user1, public_note: false)
      @n2 = Note.create(note_content: "Test Note", user: @user1, public_note: true)

      @test_category.notes << @n1
      @test_category.notes << @n2 
  end 

  after(:context) do
    @test_category.destroy
    @n1.destroy
    @n2.destroy
    @user1.destroy
  end 


  it 'creates with Name' do 
    expect(@test_category.name).to eq("Test Category")
  end
  it 'has notes' do 
    expect(@test_category.notes.length).to eq(2)
  end 

  context '#serialize' do 
    it 'custome serializes with id and name' do 
      expect(@test_category.serialize).to eq( {id: @test_category.id, name: @test_category.name} )
    end
    it 'does not serialize with created_at' do 
      expect(@test_category.serialize).not_to have_key(:created_at)
    end 
    it 'does not serialize with updated_at' do 
      expect(@test_category.serialize).not_to have_key(:updated_at)
    end 
  end

  context '#category_notes' do 
    it 'includes only public notes' do 
      expect(@test_category.category_notes.length).to eq(1)
    end 
  end 

end
