require 'rails_helper'

describe 'Admin registra uma nova categoria' do
  it 'com sucesso' do
    admin = FactoryBot.create(:user, email: 'admin@punti.com')

    login_as(admin)
    visit product_categories_path
    click_on 'Nova Categoria'
    fill_in 'Nome', with: 'Categoria teste'
    click_on 'Enviar'

    expect(page).to have_content 'Categoria teste'
    expect(page).to have_content 'Categoria criada com sucesso.'
  end

  it 'e falha pois o nome ficou em branco' do
    admin = FactoryBot.create(:user, email: 'admin@punti.com')

    login_as(admin)
    visit product_categories_path
    click_on 'Nova Categoria'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Nome não pode ficar em branco'
  end

  it 'e falha pois o nome já existe' do
    category = FactoryBot.create(:product_category)
    admin = FactoryBot.create(:user, email: 'admin@punti.com')

    login_as(admin)
    visit product_categories_path
    click_on 'Nova Categoria'
    fill_in 'Nome', with: category.name
    click_on 'Enviar'

    expect(page).to have_content 'Nome já está em uso'
  end
end
