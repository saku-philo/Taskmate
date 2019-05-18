FactoryBot.define do
  factory :user do
    id { 2 }
    name { "のび太" }
    email { "helpDoraemon@f.com" }
    password { "123456" }
    admin { true }
  end

  factory :second_user, class: User do
    id { 3 }
    name { "スネ夫" }
    email { "nobitanokuseni@f.com" }
    password { "234567" }
    admin { false }
  end

  factory :third_user, class: User do
    id { 4 }
    name { "ジャイアン" }
    email { "omaeno_monoha_orenomono@f.com" }
    password { "345678" }
    admin { false }
  end
end
