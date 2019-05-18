FactoryBot.define do

  factory :label do
    id { 1 }
    name { 'work' }
    color { 'red' }
  end

  factory :second_label, class: Label do
    id { 2 }
    name { 'travel' }
    color { 'blue' }
  end

  factory :third_label, class: Label do
    id { 3 }
    name { 'date' }
    color { 'pink' }
  end
end
