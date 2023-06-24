class RegistrationsController < Devise::RegistrationsController
  def sign_up(resource_name, resource)
    super
    return unless current_user.common?

    begin
      response_card = current_user.find_card
    rescue StandardError
      return flash[:notice] = t('.api_error')
    end

    response_tratament(response_card)
  end

  private

  def response_tratament(response)
    create_user_card(response) if response.status == 200
    flash[:notice] = t('.error') if response.status == 404
  end

  def create_user_card(response)
    @data = JSON.parse(response.body)
    flash[:notice] = t('.sucess_active')
    CardInfo.create!(user: current_user, conversion_tax: @data['conversion_tax'],
                     name: @data['name'], status: @data['status'], points: @data['points'])
  end
end
