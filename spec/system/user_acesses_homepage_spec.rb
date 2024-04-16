require 'rails_helper'

describe 'User accesses homepage' do
  it 'successfully' do
    visit root_path
  end
  it 'and sees application name' do
    visit root_path
    expect(page).to have_content("Cadê Buffet?")  
  end
end
