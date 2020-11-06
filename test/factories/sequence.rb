FactoryBot.define do
  sequence :string, aliases: [:name, :first_name, :last_name, :password] do |n|
    "string#{n}"
  end
  sequence :email do |n|
    "email#{n}@factory.com"
  end
end
