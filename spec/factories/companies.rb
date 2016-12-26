FactoryGirl.define do
  sequence(:name) do |i|
    "company #{i}"
  end
  
  factory :company do
    name
  end
end
