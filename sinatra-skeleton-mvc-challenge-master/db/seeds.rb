user1 = User.create(full_name: "Bob M")
user2 = User.create(full_name: "Lawrence M")
user4 = User.create(full_name: "Andrew M")
user3 = User.create(full_name: "Herine C")


user1.blahs.create(content: "Hi")
user2.blahs.create(content: "Hiyo")
user3.blahs.create(content: "No")
user4.blahs.create(content: "Howdy")
user1.blahs.create(content: "THIS IS ABLAH")
