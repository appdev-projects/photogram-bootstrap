FactoryBot.define do
  factory :photo do
    sequence(:image) { |n| "https://some.image/url#{n}.jpeg" }
    sequence(:caption) { |n| "Some caption #{n}" }
  end
end