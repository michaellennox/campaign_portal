require_relative 'import_votes_utils'

namespace :import_votes do

  desc "Import voting details from txt file"
  task from_txt: :environment do
    file_path = ENV['file_path'] or raise 'No file specified'
    File.open(file_path).each do |line|
      vote_line = VoteLine.new(line.mb_chars.tidy_bytes.to_s.split(' ').take(5))
      if vote_line.valid?
        vote_line.save
      end
    end
  end

end
