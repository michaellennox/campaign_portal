require 'rails_helper'
require 'rake'

RSpec.feature 'Viewing Campaigns and Results' do
  before :each do
    load File.expand_path("../../../lib/tasks/import_votes.rake", __FILE__)
    ENV['file_path'] = 'spec/test_data/test_votes.txt'
    Rake::Task.define_task(:environment)
    Rake::Task['import_votes:from_txt'].invoke
  end

  context 'Given the user has visited the campaigns portal' do
    before :each do
      visit '/campaigns'
    end

    scenario 'Then the user should see a list of the campaigns which have data' do
      within("ul#campaigns") do
        expect(page).to have_link 'ssss_uk_01A'
        expect(page).to have_link 'a_n_other'
        expect(page).to have_link 'ssss_uk_01B'
      end
    end
  end
end
