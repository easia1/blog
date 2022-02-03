FactoryBot.define do
  factory :user do
    name { 'Tarou' }
    email { "tarouyamada@test.com" }
    password { "test123" }
  end
end
