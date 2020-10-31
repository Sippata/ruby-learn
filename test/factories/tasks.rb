FactoryBot.define do
  factory :task do
    name
    description { 'MyText' }
    author factory: :manager
    assignee factory: :developer
    state { 'MyString' }
    expired_at { '2020-10-31' }
  end
end
