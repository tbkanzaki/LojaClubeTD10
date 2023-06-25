class CustomerAreasController < ApplicationController
  before_action :authenticate_user!, only: %i[index me addresses]
  before_action :prevent_admin, only: %i[index me favorite_tab addresses]
  before_action :prevent_visitor, only: %i[favorite_tab addresses]

  def index; end

  def me
    @user = current_user
  end

  def addresses
    @user = current_user
  end

  def favorite_tab
    return unless user_signed_in?

    @user = current_user
    @favorites = @user.favorites
  end

  def update_points
    begin
      response = current_user.find_card
      @data = JSON.parse(response.body)
      current_user.card_info.update!(points: @data['points'])
    rescue StandardError
      return redirect_to customer_areas_path, notice: t('.failed')
    end
    redirect_to customer_areas_path, notice: t('.success')
  end
end
