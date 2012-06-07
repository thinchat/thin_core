# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :agent do
    name "MyString"
    thin_auth_id 1
  end
end
