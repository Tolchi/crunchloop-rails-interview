FactoryBot.define do
  factory :todo do
    sequence(:description) { |d| "Descriptioin #{d}" }
    completed { false }
    association :todo_list
  end
end
