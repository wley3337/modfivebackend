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
  
    it 'correctly calls on category serilizer' do
      catTest = { id: @test_category_1.id, name: @test_category_1.name }
      expect(@n1.serialize_note[:categories]).to eq([catTest])
    end

  end

  context '#update_note' do
  
    it 'returns corectly updated note' do 
      expect(@n1).to have_attributes(note_content: "Test Note")
      updated_note = @n1.update_note("New Text", [@test_category_1.id], true)
      expect(updated_note.note_content).to eq("New Text")
    end 

    it 'clears old categories' do 
      @n1.update_note("new text", [@test_category_2.id], true)
      expect(@n1.categories).to include(@test_category_2)
    end 
  end


  context '.public_note_set' do
    before do 
      2.times do 
        Note.create(note_content: "Test Note", user: @user1, public_note: true)
      end
      @marker_note =Note.create(note_content: "Test Note", user: @user1, public_note: true)
      @false_note = Note.create(note_content: "Test Note", user: @user1, public_note: false)
      @next_note = Note.create(note_content: "Test Note", user: @user1, public_note: true)
      49.times do 
        Note.create(note_content: "Test Note", user: @user1, public_note: true)
      end 
      @over_step_note = Note.create(note_content: "Test Note", user: @user1, public_note: true)
    end

    after do 
      Category.destroy_all
      User.destroy_all
      Note.destroy_all
    end 

    it 'starts at a given note id non-inclusive' do 
      expect(Note.public_note_set(@marker_note.id).first[:note]).to eq(@next_note)
    end 

    it 'only returns notes that are public' do 
      expect(Note.public_note_set(@marker_note.id)).not_to include(@false_note)
    end

    it 'only returns 50 elements' do 
      expect(Note.public_note_set(@marker_note.id).length).to eq(50)
      expect(Note.public_note_set(@marker_note.id)).not_to include(@over_step_note)
    end 

  end 

end
