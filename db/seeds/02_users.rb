require "faker"

twenty_avatar_imgs = [
  "https://randomuser.me/api/portraits/men/32.jpg",
  "https://randomuser.me/api/portraits/men/29.jpg",
  "https://randomuser.me/api/portraits/men/35.jpg",
  "https://randomuser.me/api/portraits/men/4.jpg",
  "https://randomuser.me/api/portraits/men/22.jpg",
  "https://randomuser.me/api/portraits/men/12.jpg",
  "https://randomuser.me/api/portraits/men/52.jpg",
  "https://images.unsplash.com/photo-1455354269813-737d9df115bb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=1229aa0db2a9a42022b7669f30784123",
  "https://images.unsplash.com/photo-1502452213786-a5bc0a67e963?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=8474b116817dfa40dc19c9349a16ee5a",
  "https://images.pexels.com/photos/450212/pexels-photo-450212.jpeg?h=350&auto=compress&cs=tinysrgb",
  "https://randomuser.me/api/portraits/men/84.jpg",
  "https://randomuser.me/api/portraits/men/16.jpg",
  "https://images.unsplash.com/photo-1474533410427-a23da4fd49d0?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=ee9537f6365657688885825712e3349d",
  "https://images.unsplash.com/photo-1503593245033-a040be3f3c82?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=ca8c652b62b1f14c9c4c969289a8b33c",
  "https://randomuser.me/api/portraits/women/44.jpg",
  "https://images.unsplash.com/photo-1493666438817-866a91353ca9?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b616b2c5b373a80ffc9636ba24f7a4a9",
  "https://randomuser.me/api/portraits/women/63.jpg",
  "https://images.unsplash.com/photo-1510227272981-87123e259b17?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=3759e09a5b9fbe53088b23c615b6312e",
  "https://randomuser.me/api/portraits/women/47.jpg",
  "https://randomuser.me/api/portraits/women/95.jpg",
  "https://randomuser.me/api/portraits/women/79.jpg",
  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=046c29138c1335ef8edee7daf521ba50",
  "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://randomuser.me/api/portraits/women/8.jpg",
  "https://images.unsplash.com/photo-1520810627419-35e362c5dc07?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://randomuser.me/api/portraits/women/9.jpg",
  "https://images.unsplash.com/photo-1496081081095-d32308dd6206?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=dd302358c7e18c27c4086e97caf85781",
  "https://images.pexels.com/photos/598745/pexels-photo-598745.jpeg?crop=faces&fit=crop&h=200&w=200&auto=compress&cs=tinysrgb",
  "https://images.unsplash.com/photo-1546539782-6fc531453083?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://api.uifaces.co/our-content/donated/AVQ0V28X.jpg",
  "https://randomuser.me/api/portraits/women/33.jpg",
  "https://images.pexels.com/photos/325531/pexels-photo-325531.jpeg?h=350&auto=compress&cs=tinysrgb",
  "https://images.unsplash.com/photo-1465406325903-9d93ee82f613?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=5eb9f23d01faf52817ff797530242521"
]

puts "creating users"
20.times do
  User.create!(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "123456",
    bio: Faker::Hipster.paragraph(sentence_count: 2),
    diet: ["Vegetarian", "Vegan", "Gluten Free", "Dairy Free", "Everything"].sample,
    image_url: twenty_avatar_imgs.sample
  )
end

puts "creating Alex (alex@me.com)"
ALEX = User.create!(
  first_name: "Alex",
  last_name: "Agozzino",
  username: Faker::Internet.unique.username,
  email: "alex@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Gluten Free",
  image_url: "https://avatars.githubusercontent.com/u/59085737?v=4"
)

puts "creating Fran (fran@me.com)"
FRAN = User.create!(
  first_name: "Fran",
  last_name: "Sandford",
  username: Faker::Internet.unique.username,
  email: "fran@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Vegetarian",
  image_url: "https://avatars.githubusercontent.com/u/114738789?v=4"
)

puts "creating Ila (ila@me.com)"
ILA = User.create!(
  first_name: "Ila",
  last_name: "Peroni",
  username: Faker::Internet.unique.username,
  email: "ila@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Gluten Free",
  image_url: "https://avatars.githubusercontent.com/u/114817089?v=4"
)

puts "creating Jon (jon@me.com)"
JON = User.create!(
  first_name: "Jon",
  last_name: "Dedman",
  username: Faker::Internet.unique.username,
  email: "jon@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Everything",
  image_url: "https://avatars.githubusercontent.com/u/110668469?v=4"
)
