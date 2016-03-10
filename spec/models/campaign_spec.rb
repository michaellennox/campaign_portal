require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { is_expected.to have_many :choices }
end
