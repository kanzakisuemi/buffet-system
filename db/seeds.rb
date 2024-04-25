# bin/rails db:seed command (or created alongside the database with db:setup).
# Payment Methods
PaymentMethod.create(name: 'Cartão de Crédito')
PaymentMethod.create(name: 'Cartão de Débito')
PaymentMethod.create(name: 'Pix')
PaymentMethod.create(name: 'Transferência bancária')
PaymentMethod.create(name: 'Boleto')
PaymentMethod.create(name: 'Dinheiro')
PaymentMethod.create(name: 'Cheque')
PaymentMethod.create(name: 'Vale-refeição')

# User - Business Owner
# kendall 0
# kylie 0
# kris 1
tereza = User.create!(name: 'Tereza Kanzaki', email: 'tkanzaki@eemail.com', password: 'password123', role: 0)
felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
rafa = User.create!(name: 'Rafaela Bruschi', email: 'rafa@outlook.com', password: 'password123', role: 0)
luis_f = User.create!(name: 'Luis Fernando Marques', email: 'luis@advocacia.com', password: 'password123', role: 0)
antonia = User.create!(name: 'Antonia Grassano', email: 'antonia@angra.com', password: 'password123', role: 0)

# Buffets
Buffet.create!(
  social_name: 'Festas Criativas', 
  corporate_name: 'Tereza Kanzaki Festas LTDA',
  company_registration_number: '12366710987123',
  phone: '11987654321',
  email: 'festas@suporte.com',
  address: 'Rua das Margaridas, 1070',
  neighborhood: 'Jardim das Margaridas',
  city: 'Belém',
  state: 'PA',
  zip_code: '66000000',
  description: 'Buffet para festas infantis com enfase na decoração.',
  user: tereza
)
Buffet.create!(
  social_name: 'Planalto', 
  corporate_name: 'Buffet Planalto LTDA',
  company_registration_number: '67902479221123',
  phone: '4333385038',
  email: 'contato@planalto.com',
  address: 'Av. Tiradentes, 6429',
  neighborhood: 'Parque Ney Braga',
  city: 'Londrina',
  state: 'PR',
  zip_code: '86072000',
  description: 'Buffet para festas grandes e chiques.',
  user: felipe
)
Buffet.create!(
  social_name: 'Baby Buffet', 
  corporate_name: 'Bruschi SA',
  company_registration_number: '54094456090823',
  phone: '4333367098',
  email: 'suporte@babybuffet.com',
  address: 'Rua Santiago, 581',
  neighborhood: 'Bela Suíça',
  city: 'Londrina',
  state: 'PR',
  zip_code: '86050180',
  description: 'Buffet ideal para celebrar festas de bebês!',
  user: rafa
)
Buffet.create!(
  social_name: 'Monte Líbano', 
  corporate_name: 'Monte Líbano Restaurante e Buffet LTDA',
  company_registration_number: '88909284877622',
  phone: '4133309067',
  email: 'kuis@montelibano.com',
  address: 'Rua dos Libaneses, 670',
  neighborhood: 'Guanabara',
  city: 'Ribeirão Claro',
  state: 'PR',
  zip_code: '84070223',
  description: 'Buffet especializado em festas corporativas.',
  user: luis_f
)
Buffet.create!(
  social_name: 'Angra', 
  corporate_name: 'Angra MEI',
  company_registration_number: '89873956121456',
  phone: '4333301264',
  email: 'antonia@mail.com',
  address: 'Rua do Aurora, 508',
  neighborhood: 'Gleba Palhano',
  city: 'Londrina',
  state: 'PR',
  zip_code: '86050600',
  description: 'Buffet focado em alimentos saudáveis e fitness, refeições e doces milimetricamente avaliados pela nutri Antonia Grassano.',
  user: antonia
)
