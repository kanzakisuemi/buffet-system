require 'rails_helper'

describe 'user sees search bar' do
  it 'through homepage - as visitor' do
    visit root_path

    expect(page).to have_field('Pesquisar Buffet')
    expect(page).to have_button('Pesquisar')
  end
  it 'through buffets index - as visitor' do
    visit root_path
    click_on 'Buffets'
    expect(current_path).to eq(buffets_path)

    expect(page).to have_field('Pesquisar Buffet')
    expect(page).to have_button('Pesquisar')
  end
end
