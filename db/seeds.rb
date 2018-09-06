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


c1 = Category.create(name: "Mod 1")
c2 = Category.create(name: "Mod 2")
c3 = Category.create(name: "Mod 3")
c4 = Category.create(name: "Mod 4")
c5 = Category.create(name: "Mod 5")
c6 = Category.create(name: "JavaScript")
c7 = Category.create(name: "Ruby")
c8 = Category.create(name: "React")

n1 = Note.create(note_content: "Lose eyes get fat shew. Winter can indeed letter oppose way change tended now. So is improve my charmed picture exposed adapted demands. Received had end produced prepared diverted strictly off man branched. Known ye money so large decay voice there to. Preserved be mr cordially incommode as an. He doors quick child an point at. Had share vexed front least style off why him. 

Did shy say mention enabled through elderly improve. As at so believe account evening behaved hearted is. House is tiled we aware. It ye greatest removing concerns an overcame appetite. Manner result square father boy behind its his. Their above spoke match ye mr right oh as first. Be my depending to believing perfectly concealed household. Point could to built no hours smile sense. ", public_note: true, user_id: 2)
n2 = Note.create(note_content: "His exquisite sincerity education shameless ten earnestly breakfast add. So we me unknown as improve hastily sitting forming. Especially favourable compliment but thoroughly unreserved saw she themselves. Sufficient impossible him may ten insensible put continuing. Oppose exeter income simple few joy cousin but twenty. Scale began quiet up short wrong in in. Sportsmen shy forfeited engrossed may can. 

No depending be convinced in unfeeling he. Excellence she unaffected and too sentiments her. Rooms he doors there ye aware in by shall. Education remainder in so cordially. His remainder and own dejection daughters sportsmen. Is easy took he shed to kind. ", public_note: true, user_id: 2)
n3 = Note.create(note_content: "An country demesne message it. Bachelor domestic extended doubtful as concerns at. Morning prudent removal an letters by. On could my in order never it. Or excited certain sixteen it to parties colonel. Depending conveying direction has led immediate. Law gate her well bed life feet seen rent. On nature or no except it sussex. 

Why painful the sixteen how minuter looking nor. Subject but why ten earnest husband imagine sixteen brandon. Are unpleasing occasional celebrated motionless unaffected conviction out. Evil make to no five they. Stuff at avoid of sense small fully it whose an. Ten scarcely distance moreover handsome age although. As when have find fine or said no mile. He in dispatched in imprudence dissimilar be possession unreserved insensible. She evil face fine calm have now. Separate screened he outweigh of distance landlord.  ", public_note: false, user_id: 2)

n4 = Note.create(note_content: "An country demesne message it. Bachelor domestic extended doubtful as concerns at. Morning prudent removal an letters by. On could my in order never it. Or excited certain sixteen it to parties colonel. Depending conveying direction has led immediate. Law gate her well bed life feet seen rent. On nature or no except it sussex. 

Why painful the sixteen how minuter looking nor. Subject but why ten earnest husband imagine sixteen brandon. Are unpleasing occasional celebrated motionless unaffected conviction out. Evil make to no five they. Stuff at avoid of sense small fully it whose an. Ten scarcely distance moreover handsome age although. As when have find fine or said no mile. He in dispatched in imprudence dissimilar be possession unreserved insensible. She evil face fine calm have now. Separate screened he outweigh of distance landlord.  ", public_note: false, user_id: 3)

n5 = Note.create(note_content: "Maids table how learn drift but purse stand yet set. Music me house could among oh as their. Piqued our sister shy nature almost his wicket. Hand dear so we hour to. He we be hastily offence effects he service. Sympathize it projection ye insipidity celebrated my pianoforte indulgence. Point his truth put style. Elegance exercise as laughing proposal mistaken if. We up precaution an it solicitude acceptance invitation. 

Travelling alteration impression six all uncommonly. Chamber hearing inhabit joy highest private ask him our believe. Up nature valley do warmly. Entered of cordial do on no hearted. Yet agreed whence and unable limits. Use off him gay abilities concluded immediate allowance.", public_note: false, user_id: 3)

n1.categories << c3
n1.categories << c6
n2.categories << c1
n2.categories << c7
n4.categories << c4
n4.categories << c6
n5.categories << c6


user2.notes << n1
user2.notes << n2
user2.notes << n3

user1.notes << n5
user1.notes << n4

r1 = Reference.create(title: "React Router Docs", link: "https://reacttraining.com/react-router/web/guides/quick-start")

r2 = Reference.create(title: "Redux", link: "https://redux.js.org/")

r1.categories << c3
r1.categories << c8
r2.categories << c8
r2.categories << c4