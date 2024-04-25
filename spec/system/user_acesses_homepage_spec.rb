require 'rails_helper'

describe 'User accesses homepage' do
  it 'successfully as visitor' do
    visit root_path
  end
  it 'as visitor and sees application name' do
    visit root_path
    within('nav') do
      expect(page).to have_content("Cadê Buffet?")
    end
    expect(page).to have_content("Você está na homepage da aplicação Cadê Buffet?")
  end
end
