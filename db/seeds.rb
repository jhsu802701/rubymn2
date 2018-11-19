require 'ruby-progressbar'

########################
# BEGIN: creating admins
########################

puts '----------------------------------'
puts 'Creating super admin (Jill Tarter)'
Admin.create!(last_name: 'Tarter', first_name: 'Jill',
              username: 'jill_tarter',
              email: 'jill_tarter@rubyonracetracks.com',
              password: 'SETI Institute',
              password_confirmation: 'SETI Institute',
              confirmed_at: Time.now, super: true)

puts '----------------------------------'
puts 'Creating super admin (Frank Drake)'
Admin.create!(last_name: 'Drake', first_name: 'Frank',
              username: 'frank_drake',
              email: 'fdrake@rubyonracetracks.com',
              password: 'Drake Equation',
              password_confirmation: 'Drake Equation',
              confirmed_at: Time.now, super: true)

n_admins = 50
puts '--------------------------------------------'
puts "Creating the first #{n_admins} random admins"
pbar = ProgressBar.create(total: n_admins)
n_admins.times do |n|
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = "admin-#{n + 1}@rubyonracetracks.com"

  Admin.create!(last_name: name_l, first_name: name_f,
                username: "admin#{n + 1}",
                email: email_address, password: 'Daytona 500',
                password_confirmation: 'Daytona 500',
                confirmed_at: Time.now)
  pbar.increment
end

n_admins = 51
puts '---------------------------------------------'
puts "Creating the second #{n_admins} random admins"
pbar = ProgressBar.create(total: n_admins)
n_admins.times do |n|
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = Faker::Internet.email(name_f)

  Admin.create!(last_name: name_l, first_name: name_f,
                username: "admin-faker#{n + 1}",
                email: email_address, password: 'Daytona 500',
                password_confirmation: 'Daytona 500',
                confirmed_at: Time.now)
  pbar.increment
end

###########################
# FINISHED: creating admins
###########################

#######################
# BEGIN: creating users
#######################

email_random = %w[michael@michaelhartl.com nobu@ruby-lang.org
                  david@basecamp.com nobody@example.com]

puts '-----------------------------'
puts 'Creating user (Ellie Arroway)'
User.create!(last_name: 'Arroway', first_name: 'Ellie',
             username: 'earroway',
             email: 'ellie_arroway@rubyonracetracks.com',
             password: '3.14159265',
             password_confirmation: '3.14159265',
             confirmed_at: Time.now)

puts '----------------------------'
puts 'Creating user (Example User)'
User.create!(last_name: 'User', first_name: 'Example',
             username: 'example_user',
             email: 'example@railstutorial.org',
             gravatar_email: 'example@railstutorial.org',
             password: 'Daytona 500',
             password_confirmation: 'Daytona 500',
             confirmed_at: Time.now)

n_users = 52
puts '------------------------------------------'
puts "Creating the first #{n_users} random users"
pbar = ProgressBar.create(total: n_users)
n_users.times do |n|
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = "example-#{n + 1}@railstutorial.org"

  User.create!(last_name: name_l, first_name: name_f,
               username: "user#{n + 1}", email: email_address,
               gravatar_email: email_random.sample,
               password: 'Daytona 500',
               password_confirmation: 'Daytona 500',
               confirmed_at: Time.now)
  pbar.increment
end

n_users = 53
puts '-------------------------------------------'
pbar = ProgressBar.create(total: n_users)
puts "Creating the second #{n_users} random users"
n_users.times do |n|
  name_l = Faker::Name.last_name
  name_f = Faker::Name.first_name
  email_address = Faker::Internet.email(name_f)

  User.create!(last_name: name_l, first_name: name_f,
               username: "user-faker#{n + 1}", email: email_address,
               password: 'Daytona 500',
               password_confirmation: 'Daytona 500',
               confirmed_at: Time.now)
  pbar.increment
end

##########################
# FINISHED: creating users
##########################

###############################
# BEGIN: creating relationships
###############################

def create_relationships(user1)
  users = User.all
  puts '--------------------------------------------'
  puts "creating relationships for #{user1.username}"
  following = users[4..50]
  followers = users[5..40]
  following.each { |followed| user1.follow(followed) }
  followers.each { |follower| follower.follow(user1) }
end

create_relationships User.first
create_relationships User.second

##################################
# FINISHED: creating relationships
##################################

##########################
# BEGIN: creating sponsors
##########################

def create_sponsor(i_sponsor, status_current)
  n1 = "Sponsor #{i_sponsor}: #{Faker::Company.name}"
  p1 = Faker::PhoneNumber.phone_number
  c1 = status_current
  d1 = "SPONSOR DESCRIPTION #{i_sponsor}: "
  d1 += Faker::Company.catch_phrase.to_s
  e1 = Faker::Internet.email
  u1 = Faker::Internet.url
  Sponsor.create!(name: n1, phone: p1,
                  description: d1, contact_email: e1, contact_url: u1,
                  current: c1, remote_picture_url: Faker::Company.logo)
end

# Create past sponsors
puts 'Creating past sponsors'
n = 0
5.times do
  n += 1
  create_sponsor(n, false)
end

# Create current sponsors
puts 'Creating current sponsors'
5.times do
  n += 1
  create_sponsor(n, true)
end

puts 'Adding Pan Am (past sponsor)'
Sponsor.create!(name: 'Pan American World Airways',
                phone: '800-555-GONE',
                description: 'We used to be the largest air carrier!',
                contact_email: 'panam@example.com',
                contact_url: 'http://www.deadairline.com',
                current: false)

puts 'Adding Cyberdyne Systems (current sponsor)'
Sponsor.create!(name: 'Cyberdyne Systems',
                phone: '800-555-SKYN',
                description: 'We started Skynet!',
                contact_email: 'skynet@example.com',
                contact_url: 'http://www.cyberdine.com',
                current: true)

########################
# END: creating sponsors
########################

# DEFINE USERS
user1 = User.first # First user
users = User.all # All users

##########################
# BEGIN: creating forhires
##########################
puts 'Creating forhires'
def create_forhire(user_n, num)
  t = "Title #{num}: #{Faker::Job.title}"
  e = Faker::Internet.email
  d = "Description #{num}: #{Faker::Lorem.paragraph(10)}"
  @fh = user_n.forhires.create(title: t, email: e, description: d)
end

title1 = 'Galactic Traveler'
email1 = 'ellie_arroway@projectargus.org'
desc1 = 'I traveled around the galaxy in a dodecahedron.'
user1.forhires.create(title: title1, email: email1, description: desc1)

# Other users
n = 0
users.each do |u|
  n += 1
  next if rand < 0.2 || u == users.first

  @fh1 = create_forhire(u, n)
end

########################
# END: creating forhires
########################

##########################
# BEGIN: creating projects
##########################
puts 'Creating projects'
def create_project(user_n, num)
  t = "Project #{num}: #{Faker::Company.catch_phrase}"
  url_s = Faker::Internet.url
  url_d = Faker::Internet.url
  d = "Description #{num}: #{Faker::Lorem.paragraph(10)}"
  @p = user_n.projects.create(title: t,
                              source_code_url: url_s,
                              deployed_url: url_d,
                              description: d)
end

title1 = 'Project Argus'
url_1a = 'https://github.com/argus/find_aliens'
url_1b = 'http://www.projectargus.org'
d1 = 'Finding radio signals from alien beings'
user1.projects.create(title: title1, source_code_url: url_1a,
                      deployed_url: url_1b, description: d1)

title2 = 'Dodecahedron'
url_2a = 'https://github.com/argus/dodecahedron'
url_2b = 'http://www.dodecahedron.org'
d2 = 'Building the spacecraft with the instructions from the aliens'
user1.projects.create(title: title2, source_code_url: url_2a,
                      deployed_url: url_2b, description: d2)

# Other users
n = 0
users.each do |u|
  n += 1
  next if rand < 0.2 || u == user1

  n_projects = rand(1..3)
  n_projects.times do
    @p = create_project(u, n)
    n += 1
  end
end

########################
# END: creating projects
########################

##########################
# BEGIN: creating openings
##########################
puts 'Creating openings'
def create_opening(user_n, num)
  t = "Opening #{num}: #{Faker::Job.title}"
  d = "Description #{num}: #{Faker::Lorem.paragraph(10)}"
  @op = user_n.openings.create(title: t, description: d)
end

title1 = 'Radio signal analysis engineer'
d1 = 'Find the information in received radio waves'
user1.openings.create(title: title1, description: d1)

title2 = 'Computational engineer'
d2 = 'Calculate pi with increasingly perfect accuracy'
user1.openings.create(title: title2, description: d2)

# Other users
n = 0
users.each do |u|
  n += 1
  next if rand < 0.2 || u == user1

  n_openings = rand(1..3)
  n_openings.times do
    @op = create_opening(u, n)
    n += 1
  end
end

########################
# END: creating openings
########################
