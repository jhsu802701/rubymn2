# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/AbcSize

def add_user_objects
  @fh_connery = @u1.forhires.create(description: 'I stopped Blofeld 4 times!',
                                    email: 'first_bond@rubyonracetracks.com',
                                    title: 'James Bond 1962-1971')
  @fh_lazenby = @u2.forhires.create(description: 'I was James Bond for one movie.',
                                    email: 'george_lazenby@rubyonracetracks.com',
                                    title: 'James Bond 1969')
  @fh_moore = @u3.forhires.create(description: 'I made James Bond campier.',
                                  email: 'roger_moore@rubyonracetracks.com',
                                  title: 'James Bond 1973-1985')
  @fh_dalton = @u4.forhires.create(description: 'I brought gritty realism to the Bond series.',
                                   email: 'timothy_dalton@rubyonracetracks.com',
                                   title: 'James Bond 1987-1989')
  @fh_brosnan = @u5.forhires.create(description: 'James Bond moved beyond the Cold War Era on my watch.',
                                    email: 'pierce_brosnan@rubyonracetracks.com',
                                    title: 'James Bond 1995-2002')
  @fh_craig = @u6.forhires.create(description: 'I rebooted James Bond.',
                                  email: 'daniel_craig@rubyonracetracks.com',
                                  title: 'James Bond 2006-')

  @p1 = @u3.projects.create(title: 'Live and Let Die',
                            description: 'Investigate Kananga.',
                            source_code_url: 'https://github.com/rmoore/kananga',
                            deployed_url: 'http://www.kananga.com')
  @p2 = @u3.projects.create(title: 'The Man with the Golden Gun',
                            description: 'Get the Solex Agitator from Scaramanga.',
                            source_code_url: 'https://github.com/rmoore/scaramanga',
                            deployed_url: 'http://www.scaramanga.com')
  @p3 = @u5.projects.create(title: 'GoldenEye',
                            description: 'Stop the hijacking of the GoldenEye satellite.',
                            source_code_url: 'https://github.com/pbrosnan/goldeneye',
                            deployed_url: 'http://www.goldeneye.com')
  @p4 = @u5.projects.create(title: 'Tomorrow Never Dies',
                            description: 'Prevent war between China and the UK.',
                            source_code_url: 'https://github.com/pbrosnan/carver',
                            deployed_url: 'http://www.carvernewsnetwork.com')
  @p5 = @u6.projects.create(title: 'Quantum of Solace',
                            description: 'Get revenge for the death of Vesper Lynd.')

  @op1 = @u7.openings.create(title: 'Spacecraft Hijacker',
                             description: 'Hijack American and Soviet spacecraft')
  @op2 = @u7.openings.create(title: 'Head of Unione Corse',
                             description: 'Run a European crime syndicate')
  @op3 = @u7.openings.create(title: 'Plastic Surgeon',
                             description: 'Create fake versions of Blofeld to foil 007')
  @op4 = @u11.openings.create(title: 'Deputy',
                              description: 'Catch that black Trans Am!')
  @op5 = @u11.openings.create(title: 'Body Repair Technician',
                              description: 'Fix those police cars I keep wrecking')
end

# rubocop:enable Metrics/AbcSize

def add_extra_forhires
  users = User.all
  n = 0
  users.each do |u|
    n += 1
    next if rand < 0.2 || u.forhires.count.positive?

    u.forhires.create(description: "I report on the day's stock market action.",
                      email: "forhire#{n}@example.com",
                      title: "Daily stock market guru #{n}",
                      created_at: 11.minutes.ago,
                      updated_at: 10.minutes.ago)
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/LineLength

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/LineLength
def add_extra_projects
  users = User.all
  n = 0
  users.each do |u|
    n += 1
    next if n < 20 || rand < 0.2 || u.projects.count.positive?

    u.projects.create(title: "Project #{n}: #{Faker::Company.catch_phrase}",
                      source_code_url: Faker::Internet.url,
                      deployed_url: Faker::Internet.url,
                      description: "Description #{n}: #{Faker::Lorem.paragraph(10)}",
                      created_at: 11.minutes.ago,
                      updated_at: 10.minutes.ago)
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/LineLength

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/LineLength
def add_extra_openings
  users = User.all
  n = 0
  users.each do |u|
    n += 1
    next if n < 20 || rand < 0.2 || u.openings.count.positive?

    u.openings.create(title: "Opening #{n}: #{Faker::Job.title}",
                      description: "Description #{n}: #{Faker::Lorem.paragraph(10)}",
                      created_at: 11.minutes.ago,
                      updated_at: 10.minutes.ago)
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/LineLength
