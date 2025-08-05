FactoryBot.define do
  factory :todo_list do
    sequence(:name) { |n| "Todo list name #{n}" }
  end
end
