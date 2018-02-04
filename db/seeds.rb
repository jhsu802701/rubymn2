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
puts '------------------------------------'
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

def create_relationships(u)
  users = User.all
  puts '----------------------------------------'
  puts "creating relationships for #{u.username}"
  following = users[4..50]
  followers = users[5..40]
  following.each { |followed| u.follow(followed) }
  followers.each { |follower| follower.follow(u) }
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
