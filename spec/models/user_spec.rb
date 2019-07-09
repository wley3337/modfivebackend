require 'rails_helper'

describe User, type: :model do
    before(:context) do 
        @u1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")
    end

    after(:context) do 
        User.destroy_all
    end

    context "#serialize_user" do 
        it 'correctly serializes a user' do 
            expected_output = {id: @u1.id, username: @u1.username, firstName: @u1.first_name, lastName: @u1.last_name, roll: @u1.roll, startDate: @u1.start_date, notes: [], references: []}
            expect(@u1.serialize_user).to eq(expected_output)
        end 
    end
end 