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
# Event Type enum category: %i[corporate graduation wedding birthday other]
EventType.create!(
  category: 1,
  name: 'Formatura de Cursos',
  description: 'Festa de formatura para turmas de cursos pequenos.',
  default_duration_minutes: 180,
  minimal_people_capacity: 100,
  maximal_people_capacity: 150,
  food_menu: 'Entrada: Churros. Prato principal: Massas. Sobremesa: Bolo e sorvete.',
  alcoholic_drinks: true,
  decoration: true,
  buffet: luis_f.buffet
)
EventType.create!(
  category: 0,
  name: 'Festa Corporativa',
  description: 'Festa Corporativa para empresas de pequeno e médio porte.',
  default_duration_minutes: 50,
  minimal_people_capacity: 100,
  maximal_people_capacity: 150,
  food_menu: 'Entrada: Salada. Prato principal: Massas. Sobremesa: Bolo e sorvete.',
  alcoholic_drinks: true,
  decoration: true,
  location_flexibility: true,
  parking_service: true,
  buffet: luis_f.buffet
)
EventType.create!(
  category: 1,
  name: 'Formatura de Ensino Fundamental',
  description: 'Festa de formatura para turmas pequenas do Ensino Fundamental I e II.',
  default_duration_minutes: 180,
  minimal_people_capacity: 80,
  maximal_people_capacity: 120,
  food_menu: 'Entrada: HotDog. Prato principal: Strogonoff. Sobremesa: Bolo de Abacaxi.',
  alcoholic_drinks: false,
  decoration: true,
  location_flexibility: true,
  parking_service: false,
  buffet: rafa.buffet
)
EventType.create!(
  category: 3,
  name: 'Aniversários Infantis',
  description: 'Festa de aniversário para crianças de 1 a 12 anos.',
  default_duration_minutes: 120,
  minimal_people_capacity: 100,
  maximal_people_capacity: 150,
  food_menu: 'Entrada: Docinhos e Salgadinhos. Prato principal: Salada de Hortelã e Carne de Cordeiro. Sobremesa: Bolo de Abacaxi.',
  alcoholic_drinks: false,
  decoration: true,
  location_flexibility: true,
  parking_service: false,
  buffet: rafa.buffet
)
EventType.create!(
  category: 2,
  name: 'Casamento de Luxo',
  description: 'Casamento para casais de alto padrão.',
  default_duration_minutes: 300,
  minimal_people_capacity: 200,
  maximal_people_capacity: 400,
  food_menu: 'Entrada: Camarão Empanado. Prato principal: Risoto de Cogumelos. Sobremesa: Tiramisu.',
  alcoholic_drinks: true,
  decoration: true,
  location_flexibility: false,
  parking_service: true,
  buffet: felipe.buffet
)
EventType.create!(
  category: 3,
  name: 'Aniversários de Casamento',
  description: 'Festa de Bodas e Renovação de Votos.',
  default_duration_minutes: 180,
  minimal_people_capacity: 150,
  maximal_people_capacity: 230,
  food_menu: 'Entrada: Camarão Empanado. Prato principal: Refeição Surpresa. Sobremesa: Gelatto.',
  alcoholic_drinks: true,
  decoration: true,
  location_flexibility: false,
  parking_service: true,
  buffet: felipe.buffet
)
EventType.create!(
  category: 2,
  name: 'Casamento Tropical',
  description: 'Casamento pequeno para casais que desejam celebrar na praia.',
  default_duration_minutes: 120,
  minimal_people_capacity: 50,
  maximal_people_capacity: 100,
  food_menu: 'Entrada: Bolinho de Feijoada. Prato principal: Casquinha de Siri. Sobremesa: Salada de Frutas Gourmet.',
  alcoholic_drinks: true,
  decoration: true,
  location_flexibility: true,
  parking_service: true,
  buffet: antonia.buffet
)
EventType.create!(
  category: 3,
  name: 'Aniversários para Idosos',
  description: 'Festa de aniversário para idosos, com foco na alimentação saudável.',
  default_duration_minutes: 120,
  minimal_people_capacity: 40,
  maximal_people_capacity: 60,
  food_menu: 'Entrada: Salada de Tomate. Prato principal: Risoto de Frutos do Mar. Sobremesa: Laranjas com Canela.',
  alcoholic_drinks: false,
  decoration: true,
  location_flexibility: true,
  parking_service: false,
  buffet: antonia.buffet
)

