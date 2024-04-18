# frozen_string_literal: true

namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    puts 'Resetando banco de daoos'

    `rails db:drop db:create db:migrate`

    puts 'Cadastrando os tipos de contato...'

    kinds = %w[Amigo Comercial Conhecido]

    kinds.each do |kind|
      Kind.create!(description: kind)
    end

    puts 'Tipos Contato cadastrrados com sucesso!'

    puts 'Cadastrando os contatos...'

    100.times do |_i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 35.days.ago, to: Date.today),
        kind: Kind.all.sample
      )
    end

    puts 'Contatos cadastrados com sucesso'

    # CADASTRANDO OS TELEFONES
    puts 'cadastrando os telefones'

    Contact.all.each do |contact|
      Random.rand(1..5).times do
        contact.phones.create!(number: Faker::PhoneNumber.cell_phone)
      end
    end

    puts 'Telefones cadastrados com sucesso'

    # CADASTRANDO OS ENDERECOS
    puts 'cadastrando os Endereços'

    Contact.all.each do |contact|
      Address.create(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
    puts 'Endereços cadastrados com sucesso'
  end
end
