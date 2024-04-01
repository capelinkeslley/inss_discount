# frozen_string_literal: true

FactoryBot.create(:user, email: 'first_user@email.com', password: '123123', confirmed_at: DateTime.current)

FactoryBot.create(:proponent, gross_salary: 1000.0)
FactoryBot.create(:proponent, gross_salary: 1300.0)
FactoryBot.create(:proponent, gross_salary: 1500.0)
FactoryBot.create(:proponent, gross_salary: 1800.0)
FactoryBot.create(:proponent, gross_salary: 2000.0)
FactoryBot.create(:proponent, gross_salary: 2300.0)
FactoryBot.create(:proponent, gross_salary: 2600.0)
FactoryBot.create(:proponent, gross_salary: 2800.0)
FactoryBot.create(:proponent, gross_salary: 3000.0)
FactoryBot.create(:proponent, gross_salary: 3500.0)
