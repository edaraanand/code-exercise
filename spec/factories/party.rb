FactoryGirl.define do
  factory :party, class: Party do
    host_name { Faker::Lorem.characters(255) }
    host_email { Faker::Lorem.characters(255) }
    numgsts { Faker::Number.number(3) }
    descript { Faker::Lorem.characters(555) }
    venue { Faker::Lorem.characters(255) }
    location { Faker::Lorem.characters(255) }
    theme { Faker::Lorem.characters(255) }
    description { Faker::Lorem.characters(255) }
    whenn {Faker::Date.backward(14)}
    when_its_over {Faker::Date.backward(14)}
    descript { Faker::Lorem.characters(555) }
  end
end
