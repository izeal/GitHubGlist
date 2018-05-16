User.create(
    name:'Ivan',
    email: 'foo@bar.baz',
    password: 'foobar',
)

12.times do |n|
  name = Faker::Friends.unique.character.gsub(" ", "_")
  User.create(
    name: name,
    email: "#{name}@bar.baz",
    password: 'foobar'
  )
end

users = User.all

users.each do |user|
  rand(0..4).times do
    description = Faker::Friends.quote
    body = Faker::Lorem.paragraphs(rand(20), true).join
    user.gists.create(description: description, body: body)
  end
end

gists = Gist.all

gists.each do |gist|
  rand(0..6).times do
    gist.comments.create(body: Faker::Lorem.paragraphs(rand(10), true).join, user_id: users.sample.id)
  end
end
