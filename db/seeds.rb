ActionMailer::Base.perform_deliveries = false

User.create(
    name:'Ivan',
    email: 'foo@bar.baz',
    password: 'foobar',
)

puts
12.times do |n|
  name = Faker::Friends.unique.character.gsub(" ", "_")
  User.create(
    name: name,
    email: "#{name}@bar.baz",
    password: 'foobar'
  )
  print '.'
end

########
users = User.all

puts
users.each do |user|
  rand(0..4).times do
    description = Faker::Friends.quote
    body = Faker::Lorem.paragraphs(rand(20), true).join
    user.gists.create(description: description, body: body)
  end
  print '.'
end


puts
users_id = users.map(&:id)
users.each do |user|
  arr_past_id = [user.id]
  rand(5..users.count).times do
    sample_id = users_id.sample
    unless arr_past_id.include?(sample_id)
      arr_past_id << sample_id
      user.active_relationships.create(followed_id: sample_id)
    end
  end
  print '.'
end

puts
users.each do |user|
  user.remote_avatar_url = Faker::Avatar.image
  print '.'
end

########
gists = Gist.all

puts
gists.each do |gist|
  rand(0..6).times do
    gist.comments.create(body: Faker::Lorem.paragraphs(rand(10), true).join, user_id: users.sample.id)
  end
  print '.'
end

puts
gists.each do |gist|
  rand(0..1).times do
    gist.update(pincode: 1111)
  end
  print '.'
end

puts
gists.each do |gist|
  arr_past_id = [gist.user.id]
  rand(0..users.count).times do
    sample_id = users_id.sample
    unless arr_past_id.include?(sample_id)
      arr_past_id << sample_id
      gist.stars.create(user_id: sample_id)
    end
  end
  print '.'
end

########
puts
users.each do |user|
  user.update(confirmed_at: Time.now)
  print '.'
end

puts
