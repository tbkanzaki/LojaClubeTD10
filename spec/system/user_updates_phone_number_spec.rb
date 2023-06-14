require 'rails_helper'

describe 'Usuário atualiza o número de telefone' do
  it 'a partir do campo em minhas informações' do
    user = FactoryBot.create(:user, phone_number: '19934567890')

    login_as(user)
    visit root_path
    click_on 'Área do Cliente'
    click_on 'Minhas Informações'

    expect(page).to have_field 'phone_number', with: '(19)93456-7890'
    expect(page).to have_button 'Atualizar Contato'
  end
  it 'com sucesso' do
    user = FactoryBot.create(:user, phone_number: '19934567890')

    login_as(user)
    visit root_path
    click_on 'Área do Cliente'
    click_on 'Minhas Informações'
    fill_in 'phone_number',	with: '(19)93456-7823'
    click_on 'Atualizar Contato'

    expect(current_path).to eq me_path
    expect(page).to have_content 'Número de telefone atualizado com sucesso'
    expect(page).to have_field 'phone_number', with: '(19)93456-7823'
  end
end
