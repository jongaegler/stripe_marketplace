FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    password { 'password' }
  end

  factory :product do
    title { "Test" }
    description  { "This is a test" }
    price { 100 }
    user
  end
end
