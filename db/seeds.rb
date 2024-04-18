# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PaymentMethod.create(name: 'Cartão de Crédito')
PaymentMethod.create(name: 'Cartão de Débito')
PaymentMethod.create(name: 'Pix')
PaymentMethod.create(name: 'Transferência bancária')
PaymentMethod.create(name: 'Boleto')
PaymentMethod.create(name: 'Dinheiro')
PaymentMethod.create(name: 'Cheque')
PaymentMethod.create(name: 'Vale-refeição')
