FactoryBot.define do
  factory :task do
    name
    description
    author factory: :manager
    assignee factory: :developer
    expired_at { 2.days.from_now }
  end
end
