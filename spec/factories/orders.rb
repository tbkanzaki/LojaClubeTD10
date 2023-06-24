FactoryBot.define do
  factory :order do
    total_value { 1000 }
    discount_amount { 0 }
    final_value { 1000 }
    cpf { '09777513097' }
    user { create(:user) }
  end
end
