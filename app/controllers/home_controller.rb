class HomeController < ApplicationController
  def index
    @products = Product.order(created_at: :desc).filter { |p| p.product_category.active? }

    @campaigns = []

    cnpj = session[:company_cnpj]
    company = Company.find_by(registration_number: cnpj)
    return if company&.promotional_campaigns.blank?

    company.promotional_campaigns.each do |campaign|
      @campaigns << campaign if campaign.products.any?
    end
  end
end
