require "faker"

avatar_imgs = [
  "https://randomuser.me/api/portraits/women/44.jpg",
  "https://randomuser.me/api/portraits/women/63.jpg",
  "https://randomuser.me/api/portraits/women/47.jpg",
  "https://randomuser.me/api/portraits/women/95.jpg",
  "https://randomuser.me/api/portraits/women/79.jpg",
  "https://randomuser.me/api/portraits/women/14.jpg",
  "https://randomuser.me/api/portraits/women/8.jpg",
  "https://randomuser.me/api/portraits/women/9.jpg",
  "https://randomuser.me/api/portraits/women/33.jpg",
  "https://randomuser.me/api/portraits/women/48.jpg",
  "https://randomuser.me/api/portraits/men/32.jpg",
  "https://randomuser.me/api/portraits/men/29.jpg",
  "https://randomuser.me/api/portraits/men/35.jpg",
  "https://randomuser.me/api/portraits/men/4.jpg",
  "https://randomuser.me/api/portraits/men/7.jpg",
  "https://randomuser.me/api/portraits/men/22.jpg",
  "https://randomuser.me/api/portraits/men/12.jpg",
  "https://randomuser.me/api/portraits/men/52.jpg",
  "https://randomuser.me/api/portraits/men/84.jpg",
  "https://randomuser.me/api/portraits/men/16.jpg"
]
specific_users = [
  {
    first_name: "Ila",
    last_name: "Peroni",
    image_url: "https://avatars.githubusercontent.com/u/114817089?v=4"
  },
  {
    first_name: "Alex",
    last_name: "Agozzino",
    diet: "Gluten-free",
    image_url: "https://avatars.githubusercontent.com/u/59085737?v=4"
  },
  {
    first_name: "Jon",
    last_name: "Dedman",
    image_url: "https://avatars.githubusercontent.com/u/110668469?v=4"
  },
  {
    first_name: "Fran",
    last_name: "Sandford"
  }
]

def create_users(user, avatar_imgs = [])
  User.create!(
    first_name: user[:first_name] || Faker::Name.unique.first_name,
    last_name: user[:last_name] || Faker::Name.unique.last_name,
    username: Faker::Internet.unique.username,
    email: user[:first_name] ? "#{user[:first_name].downcase}@me.com" : Faker::Internet.unique.email,
    password: "123456",
    bio: Faker::Hipster.paragraph(sentence_count: 3),
    diet: user[:diet] || ["Vegetarian", "Vegan", "Gluten-free", "Dairy-free", "Everything"].sample,
    image_url: user[:image_url] || avatar_imgs.sample
  )
end

# creates 20 random users
20.times { create_users({}, avatar_imgs) }

# creates 4 specific users
ILA = create_users(specific_users[0])
ALEX = create_users(specific_users[1])
JON = create_users(specific_users[2])
FRAN = create_users(specific_users[3], avatar_imgs)
