require 'rails_helper'

describe Note, type: :model do

  before(:context) do 
    @test_category_1 = Category.create(name: "Test Category 1")
    @test_category_2 = Category.create(name: "Test Category 2")
    @user1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")
    @n1 = Note.create(note_content: "Test Note", user: @user1, public_note: false)
    @n2 = Note.create(note_content: "Test Note", user: @user1, public_note: true)

    @test_category_1.notes << @n1
    @test_category_2.notes << @n2 
  end 

  after(:context) do
    Category.destroy_all
    User.destroy_all
    Note.destroy_all
  end 

  context '.public?' do
      it 'only returns public notes' do
        expect(Note.public?).to eq([@n2])
      end 
  end 

  context '#add_categories' do
    it 'given an array of category ids it adds them to the note' do 
      testText = "note creation"
      public_note = false
      category_ids_array = [@test_category_2.id]
      localTestNote = Note.new(note_content: testText, public_note: public_note, user: @user1)
      localTestNote.add_categories(category_ids_array)
      expect(localTestNote.categories).to eq([@test_category_2])
    end 
  end 

  context '.creation' do
    it 'creates new note with proper categories' do 
      testText = "note creation"
      public_note = false
      category_ids_array = [@test_category_2.id]
    
      expect(Note.creation(@user1, testText,category_ids_array, public_note).categories).to eq([@test_category_2])
    end 
    
    it 'creates new note with proper text' do 
      testText = "note creation"
      public_note = false
      category_ids_array = [@test_category_2.id]
    
      expect(Note.creation(@user1, testText,category_ids_array, public_note).note_content).to eq(testText)
    end 
  end


  context '#serialize_note' do
  
    xit 'correctly calls on category serilizer' do

    end

  end

  context '#update_note' do
    xit 'clears old categories' do 

    end 

    xit 'returns corectly updated note' do 

    end 
  end


  context '.public_note_set' do

    xit 'starts at a given note id' do 

    end 

    xit 'only returns notes that are public'do 

    end

  end 

end
