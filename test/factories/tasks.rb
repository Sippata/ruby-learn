FactoryBot.define do
  factory :task do
    name
    description { generate :string }
    author factory: :manager
    assignee factory: :developer
    expired_at { 2.days.from_now }
  end
end
