FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name 'Test'
    password 'password'
    password_confirmation 'password'
  end

  factory :list do
    label 'default list label'
  end

  factory :task do
    content 'default task content'
    position 1
  end
end