FactoryBot.define do
  factory :question do
    code 0
    category 'category'
    text 'text'
    correct_answer true
  end

  trait :invalid_question do
    code 404
  end
end
