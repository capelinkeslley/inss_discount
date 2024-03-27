# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    document { CPF.generate }
    date_of_birth { 20.years.ago }
    main_contact { Faker::PhoneNumber.cell_phone_in_e164 }
    secondary_contact { Faker::PhoneNumber.cell_phone_in_e164 }
    gross_salary { 3_000.00 }
    net_salary { 2_718.38 }
    discount { 281.62 }
  end
end
