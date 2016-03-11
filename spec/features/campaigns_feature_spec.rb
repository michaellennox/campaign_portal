require 'rails_helper'
require 'rake'

load File.expand_path("../../../lib/tasks/import_votes.rake", __FILE__)
ENV['file_path'] = 'spec/test_data/test_votes.txt'
Rake::Task.define_task(:environment)

RSpec.feature 'Viewing Campaigns and Results' do
  before :each do
    Rake::Task['import_votes:from_txt'].reenable
    Rake::Task['import_votes:from_txt'].invoke
  end

  context 'When the user has visited the campaigns portal' do
    before :each do
      visit '/campaigns'
    end

    scenario 'Then the user should see a list of the campaigns which have data' do
      within('ul#campaigns') do
        expect(page).to have_link 'ssss_uk_01A'
        expect(page).to have_link 'a_n_other'
        expect(page).to have_link 'ssss_uk_01B'
      end
    end

    context 'and the user has clicked through to a particular campaign' do
      before :each do
        click_link 'ssss_uk_01B'
      end

      scenario 'Then the user should see the list of candidates, scores and uncounted messages' do
        within('ul#candidates') do
          within('li:first-child') do
            expect(page).to have_content 'Leon'
            expect(page).to have_content 'Votes: 1'
          end
          within('li:last-child') do
            expect(page).to have_content 'Jane'
            expect(page).to have_content 'Votes: 1'
          end
        end
        within('#uncounted-votes') do
          expect(page).to have_content 'Uncounted Votes: 3'
        end
      end
    end
  end
end
