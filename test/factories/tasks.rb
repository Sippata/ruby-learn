FactoryBot.define do
  factory :task do
    name
    description { 'MyText' }
    author_id { 1 }
    assignee_id { 1 }
    state { 'MyString' }
    expired_at { '2020-10-31' }
  end
end
