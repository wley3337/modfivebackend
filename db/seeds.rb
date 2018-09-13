# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# user = User.new((username: new_user_params["username"], first_name: new_user_params["firstName"], last_name: new_user_params["lastName"], password: new_user_params["password"], start_date: new_user_params["startDate"])

admin = User.create(username: "admin", first_name: "adminFristName", last_name: "adminLastName", password: "admin123", start_date: "2012-01-01".to_date, roll: "admin")

user1 = User.create(username: "user1", first_name: "user1FristName", last_name: "user1LastName", password: "user1123", start_date: "2012-01-01".to_date, roll: "student")

user2 = User.create(username: "user2", first_name: "user2FristName", last_name: "user2LastName", password: "user2123", start_date: "2012-01-01".to_date, roll: "student")

user3 = User.create(username: "user3", first_name: "user3FristName", last_name: "user3LastName", password: "user3123", start_date: "2012-01-01".to_date, roll: "student")


# category seeds

    c1 = Category.create(name: "Mod 1")
    c2 = Category.create(name: "Mod 2")
    c3 = Category.create(name: "Mod 3")
    c4 = Category.create(name: "Mod 4")
    c5 = Category.create(name: "Mod 5")
    c6 = Category.create(name: "JavaScript")
    c7 = Category.create(name: "Ruby")
    c8 = Category.create(name: "React")
    c9 = Category.create(name: "Redux")
    c10 = Category.create(name: "CSS")
    c11 = Category.create(name: "Rails")
    c12 = Category.create(name: "Redux")


catArray = [c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12]
x=0
while x <= 310 

    n = Note.create(
        note_content: Faker::Lovecraft.paragraph(rand(1..8)) + Faker::Lovecraft.paragraph(rand(1..8)),
        public_note: true,
        user_id: 2
    )
    n.categories << catArray[rand(0..4)]
    n.categories << catArray[rand(5..8)]
    n.categories << catArray[rand(9..11)]
    user1.notes << n
    x += 1
end
x=0
while x <= 310 

    n = Note.create(
        note_content: Faker::Lovecraft.paragraph(rand(1..8)) + Faker::Lovecraft.paragraph(rand(1..8)),
        public_note: true,
        user_id: 3
    )
    n.categories << catArray[rand(0..4)]
    n.categories << catArray[rand(5..8)]
    n.categories << catArray[rand(9..11)]
    user2.notes << n
    x += 1
end
x=0
while x <= 310 

    n = Note.create(
        note_content: Faker::Lovecraft.paragraph(rand(1..8)) + Faker::Lovecraft.paragraph(rand(1..8)),
        public_note: true,
        user_id: 4
    )
    n.categories << catArray[rand(0..4)]
    n.categories << catArray[rand(5..8)]
    n.categories << catArray[rand(9..11)]
    user3.notes << n
    x += 1
end

x=0
while x <= 50 

    n = Note.create(
        note_content: Faker::Lovecraft.paragraphs(10),
        public_note: false,
        user_id: 3
    )
    n.categories << catArray[rand(0..4)]
    n.categories << catArray[rand(5..8)]
    n.categories << catArray[rand(9..11)]
    user2.notes << n
    x += 1
end
x=0
while x <= 50 

    n = Note.create(
        note_content: Faker::Lovecraft.paragraph(10),
        public_note: false,
        user_id: 4
    )
    n.categories << catArray[rand(0..4)]
    n.categories << catArray[rand(5..8)]
    n.categories << catArray[rand(9..11)]
    user3.notes << n
    x += 1
end



# reference and category assignment

r1 = Reference.create(title: "React Router Docs", link: "https://reacttraining.com/react-router/web/guides/quick-start", saves: 1)
r1.categories << c3
r1.categories << c8

r2 = Reference.create(title: "Redux", link: "https://redux.js.org/", saves: 1)
r2.categories << c8
r2.categories << c4

r3 = Reference.create(title: "Ruby Array Methods", link: "https://docs.ruby-lang.org/en/2.0.0/Array.html")
r3.categories << c7

r4 = Reference.create(title: "Ruby Hash Methods", link: "https://docs.ruby-lang.org/en/2.0.0/Hash.html")
r4.categories << c7

r5 = Reference.create(title: "Ruby String Methods", link: "https://ruby-doc.org/core-2.2.0/String.html", saves: 1)
r5.categories << c7


r6 = Reference.create(title: "Lucid Chart", link: "https://www.lucidchart.com/users/login#docs?folder_id=home&browser=icon&sort=saved-desc")
r6.categories << c5

r7 = Reference.create(title: "Color Palettes", link: "https://coolors.co/")
r7.categories << c10

r8 = Reference.create(title: "React Docs", link: "https://reactjs.org/")
r8.categories << c5
r8.categories << c8

r9 = Reference.create(title: "Semantic UI React", link: "https://react.semantic-ui.com/")
r9.categories << c8
r9.categories << c4
r9.categories << c5

r10 = Reference.create(title: "Rails Docs", link: "https://edgeguides.rubyonrails.org/")
r10.categories << c2
r10.categories << c7
r10.categories << c11

r11 = Reference.create(title: "Google Fonts", link: "https://fonts.google.com/")
r11.categories << c10
r11.categories << c2 
r11.categories << c3 
r11.categories << c4
r11.categories << c5

r12 = Reference.create(title: "Deploy Rails on Heroku", link: "https://medium.com/@kasiarosenb/deploying-your-rails-app-on-heroku-a2096dc40aac")
r12.categories << c11
r12.categories << c2
r12.categories << c3
r12.categories << c4
r12.categories << c5



# user reference assignments
user1.references << r1 
user1.references << r2
user1.references << r4


user2.references << r2 
user2.references << r10
user2.references << r11 
user2.references << r6 
user2.references << r8

user3.references << r3 
user3.references << r2
user3.references << r1
user3.references << r7 
user3.references << r10