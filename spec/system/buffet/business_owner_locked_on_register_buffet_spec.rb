require 'rails_helper'

describe 'business owner without buffet tries to' do
  it 'access homepage and is locked on buffet register page' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    login_as(kylie)
    visit root_path

    expect(current_path).to eq(new_buffet_path)
  end
  it 'get to homepage' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    login_as(kylie)
    visit root_path

    expect(current_path).to eq(new_buffet_path)

    within('nav') do
      click_on 'Cadê Buffet?'
    end

    expect(current_path).to eq(new_buffet_path)
  end
  it 'logout and it works' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    login_as(kylie)
    visit root_path

    expect(current_path).to eq(new_buffet_path)

    within('nav') do
      click_on 'Sair'
    end

    expect(current_path).to eq(root_path)
  end
end
