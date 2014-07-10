# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookmark do
    link "MyString"
    topic "MyString"
    user nil
  end
end
