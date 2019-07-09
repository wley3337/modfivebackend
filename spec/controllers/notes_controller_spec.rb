require 'rails_helper'

describe NotesController, type: :controller do 
    it 'returns status of 401 when user not logged in' do
        get :index, params: {:offsetId => 1}
        expect(response.status).to eq(401)
    end

    context "user logged in" do
        before do 
            @user1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")
            #tests depend on only one note being not public
            @n1 = Note.create(note_content: "Test Note to find not", user: @user1, public_note: false)
            @note_to_find = Note.create(note_content: "Test Note to find", user: @user1, public_note: true)
            
            20.times do 
                Note.create(note_content: "Test Note", user: @user1, public_note: true)
            end 
            # mocks authenticate for controller
            allow(controller).to receive(:authenticate).and_return(@user1)
        end

        after do 
            User.destroy_all
            Note.destroy_all
        end 
        context ':index' do
            it 'returns all public notes' do 
                get :index , params: {offsetId: @n1.id}
                expect(JSON.parse(response.body)['notes'].length).to eq(Note.all.length - 1)
            end 
    
            it 'returns a limit of 50 notes' do 
                40.times do 
                    Note.create(note_content: "Test Note", user: @user1, public_note: true)
                end 
                get :index, params: {offsetId: @n1.id}
                expect(JSON.parse(response.body)['notes'].length).to eq(50)
            end
        end

        context ':search_index' do
            it 'returns only public notes including searchterm' do
                get :search_index , params: {offsetId: @n1.id, searchTerm: "Note to find"}
                expect(JSON.parse(response.body)['notes'].length).to eq(1)

            end
        end

        context ':destroy' do
            it 'does destroy a note if a user ownes it' do 
                num_of_notes_before = Note.all.length 
                delete :destroy , params: {note:{ id: @n1.id}} 
                expect(Note.all.length).to eq(num_of_notes_before - 1)
            end 
            
            it 'does not destroy a note if a user does not owne it' do 
                user2 = User.create(username: "user2", first_name: "user2FristName", last_name: "user2LastName", password: "user2123", start_date: "2012-01-01".to_date, roll: "student") 
                do_not_destroy = Note.create(note_content: "Test Note", user: user2, public_note: true)
                num_of_notes_before = Note.all.length
                delete :destroy , params: {note:{ id: do_not_destroy.id}}
                expect(Note.all.length).to eq(num_of_notes_before)

            end

        end

    end 
    
end