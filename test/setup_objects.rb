# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/LineLength

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
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/LineLength
