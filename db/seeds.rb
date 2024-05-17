# bin/rails db:seed command (or created alongside the database with db:setup).
# Payment Methods
credito = PaymentMethod.create(name: 'Cartão de Crédito')
debito = PaymentMethod.create(name: 'Cartão de Débito')
pix = PaymentMethod.create(name: 'Pix')
ted = PaymentMethod.create(name: 'Transferência bancária')
boleto = PaymentMethod.create(name: 'Boleto')
cedula = PaymentMethod.create(name: 'Dinheiro')
cheque = PaymentMethod.create(name: 'Cheque')
vale = PaymentMethod.create(name: 'Vale-refeição')

# Users - Business Owner
tereza = User.create!(name: 'Tereza Kanzaki', email: 'tkanzaki@eemail.com', password: 'password123', role: 0)
felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
rafa = User.create!(name: 'Rafaela Bruschi', email: 'rafa@outlook.com', password: 'password123', role: 0)
luis_f = User.create!(name: 'Luis Fernando Marques', email: 'luis@advocacia.com', password: 'password123', role: 0)
antonia = User.create!(name: 'Antonia Grassano', email: 'antonia@angra.com', password: 'password123', role: 0)
# Users - Client
julia = User.create!(name: 'Julia Kanzaki', email: 'kanzaki@myself.com', password: 'password123', role: 1, social_security_number: CPF.generate)
pablo = User.create!(name: 'Pablo Marçal', email: 'plabom@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
felca = User.create!(name: 'Felipe Bressanim', email: 'felca@youtuber.com', password: 'password123', role: 1, social_security_number: CPF.generate)
orochinho = User.create!(name: 'Pedro Orochi', email: 'pedro@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)

# Buffets
Buffet.create!(
  social_name: 'Festas Criativas', 
  corporate_name: 'Tereza Kanzaki Festas LTDA',
  company_registration_number: CNPJ.generate,
  events_per_day: 2,
  phone: '11987654321',
  email: 'festas@suporte.com',
  address: 'Rua das Margaridas, 1070',
  neighborhood: 'Jardim das Margaridas',
  city: 'Belém',
  state: 'PA',
  zip_code: '66000000',
  description: 'Buffet para festas infantis com enfase na decoração.',
  user: tereza,
  payment_methods: [ pix, ted, cheque, vale ] 
)
Buffet.create!(
  social_name: 'Planalto', 
  corporate_name: 'Buffet Planalto LTDA',
  company_registration_number: CNPJ.generate,
  events_per_day: 5,
  phone: '4333385038',
  email: 'contato@planalto.com',
  address: 'Av. Tiradentes, 6429',
  neighborhood: 'Parque Ney Braga',
  city: 'Londrina',
  state: 'PR',
  zip_code: '86072000',
  description: 'Buffet para festas grandes e chiques.',
  user: felipe,
  payment_methods: [ credito, debito, pix, ted, boleto ] 
)
Buffet.create!(
  social_name: 'Baby Buffet', 
  corporate_name: 'Bruschi SA',
  company_registration_number: CNPJ.generate,
  events_per_day: 1,
  phone: '4333367098',
  email: 'suporte@babybuffet.com',
  address: 'Rua Santiago, 581',
  neighborhood: 'Bela Suíça',
  city: 'Londrina',
  state: 'PR',
  zip_code: '86050180',
  description: 'Buffet ideal para celebrar festas de bebês!',
  user: rafa,
  payment_methods: [ credito, debito, pix, ted, boleto ]
)
Buffet.create!(
  social_name: 'Monte Líbano', 
  corporate_name: 'Monte Líbano Restaurante e Buffet LTDA',
  company_registration_number: CNPJ.generate,
  events_per_day: 3,
  phone: '4133309067',
  email: 'luis@montelibano.com',
  address: 'Rua dos Libaneses, 670',
  neighborhood: 'Guanabara',
  city: 'Ribeirão Claro',
  state: 'PR',
  zip_code: '84070223',
  description: 'Buffet especializado em festas corporativas.',
  user: luis_f,
  payment_methods: [ credito, debito, pix, ted ] 
)
Buffet.create!(
  social_name: 'Angra', 
  corporate_name: 'Angra MEI',
  company_registration_number: CNPJ.generate,
  events_per_day: 2,
  phone: '4333301264',
  email: 'antonia@mail.com',
  address: 'Rua do Aurora, 508',
  neighborhood: 'Gleba Palhano',
  city: 'Londrina',
  state: 'PR',
  zip_code: '86050600',
  description: 'Buffet focado em alimentos saudáveis e fitness, refeições e doces milimetricamente avaliados pela nutri Antonia Grassano.',
  user: antonia,
  payment_methods: [ pix ] 
)
# Event Type enum category: %i[corporate graduation wedding birthday other]
formatura_curso = EventType.create!(
  category: 1,
  name: 'Formatura de Cursos',
  description: 'Festa de formatura para turmas de cursos pequenos.',
  default_duration_minutes: 180,
  minimal_people_capacity: 100,
  maximal_people_capacity: 150,
  food_menu: 'Entrada: Churros. Prato principal: Massas. Sobremesa: Bolo e sorvete.',
  alcoholic_drinks: true,
  decoration: true,
  buffet: luis_f.buffet,
  base_price: 10000.00,
  weekend_fee: 25,
  per_person_fee: 90.00,
  per_person_weekend_fee: 10,
  per_hour_fee: 250.00,
  per_hour_weekend_fee: 10
)
festa_corporativa = EventType.create!(
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
  buffet: luis_f.buffet,
  base_price: 10000.00,
  weekend_fee: 25,
  per_person_fee: 70.00,
  per_person_weekend_fee: 10,
  per_hour_fee: 70.00,
  per_hour_weekend_fee: 10
)
formatura_crianca = EventType.create!(
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
  buffet: rafa.buffet,
  base_price: 4000.00,
  weekend_fee: 25,
  per_person_fee: 40.00,
  per_person_weekend_fee: 10,
  per_hour_fee: 200.00,
  per_hour_weekend_fee: 10
)
niver_crianca = EventType.create!(
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
  buffet: rafa.buffet,
  base_price: 8000.00,
  weekend_fee: 25,
  per_person_fee: 90.00,
  per_person_weekend_fee: 10,
  per_hour_fee: 100.00,
  per_hour_weekend_fee: 10
)
casamento_luxo = EventType.create!(
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
  buffet: felipe.buffet,
  base_price: 15000.00,
  weekend_fee: 20,
  per_person_fee: 70.00,
  per_person_weekend_fee: 20,
  per_hour_fee: 400.00,
  per_hour_weekend_fee: 50
)
bodas = EventType.create!(
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
  buffet: felipe.buffet,
  base_price: 9000.00,
  weekend_fee: 10,
  per_person_fee: 70.00,
  per_person_weekend_fee: 20,
  per_hour_fee: 400.00,
  per_hour_weekend_fee: 50
)
casamento_tropical = EventType.create!(
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
  buffet: antonia.buffet,
  base_price: 5000.00,
  weekend_fee: 25,
  per_person_fee: 60.00,
  per_person_weekend_fee: 10,
  per_hour_fee: 200.00,
  per_hour_weekend_fee: 10
)
niver_idoso = EventType.create!(
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
  buffet: antonia.buffet,
  base_price: 1000.00,
  weekend_fee: 20,
  per_person_fee: 50.00,
  per_person_weekend_fee: 20,
  per_hour_fee: 100.00,
  per_hour_weekend_fee: 50
)
# Orders
Order.create!(
  event_date: 12.days.from_now,
  guests_estimation: 45,
  event_details: 'Festa de aniversário de 10 anos da Clara',
  event_address: nil,
  event_type_id: niver_crianca.id,
  user: felca,
  status: 3
)
casamento_pablo = Order.create!(
  event_date: 30.days.from_now,
  guests_estimation: 400,
  event_details: 'Casamento luxuoso instagramavel.',
  event_address: nil,
  event_type_id: casamento_luxo.id,
  user: pablo,
  status: 0
)
Order.create!(
  event_date: 30.days.from_now,
  guests_estimation: 230,
  event_details: 'Casamento tradicional católico.',
  event_address: nil,
  event_type_id: casamento_luxo.id,
  user: julia,
  status: 0
)
Order.create!(
  event_date: 20.days.from_now,
  guests_estimation: 150,
  event_details: 'Festa de Bodas de Prata dos pais.',
  event_address: nil,
  event_type_id: bodas.id,
  user: felca,
  status: 1,
  due_date: 10.days.from_now,
  payment_method_id: debito.id,
  grant_discount: true,
  discount: 200.00,
  charge_fee: false,
  extra_fee: nil,
  budget_details: 'Desconto para cliente conhecido.'
)
festa_manikas = Order.create!(
  event_date: 6.days.from_now,
  guests_estimation: 50,
  event_details: 'Festa corporativa do Manikas HEHE',
  event_address: 'Avenida Maringá, 808',
  event_type_id: festa_corporativa.id,
  user: orochinho,
  status: 2,
  due_date: 3.days.from_now,
  payment_method_id: pix.id,
  grant_discount: false,
  discount: nil,
  charge_fee: true,
  extra_fee: 200.00,
  budget_details: 'Taxa extra para aluguel e deslocamento de louças.'
)
# Message
Message.create!(content: 'Olá Pablo, tudo bem?', order_id: casamento_pablo.id, user: felipe)
Message.create!(content: 'Gostaria de saber se poderia me explicar melhor qual seria o casamento ideal para você!', order_id: casamento_pablo.id, user: felipe)
Message.create!(content: 'Oi Felipe, estou bem sim, graças a Deus e você?', order_id: casamento_pablo.id, user: pablo)
Message.create!(content: 'Idealmente seria um casamento com foco na decoração, doces de luxo e bons drinks.', order_id: casamento_pablo.id, user: pablo)
Message.create!(content: 'Você teria disponibilidade para uma reunião via zoom ou até mesmo presecial.', order_id: casamento_pablo.id, user: pablo)
Message.create!(content: 'Acho que seria ótimo se pudessemos marcar com a minha esposa. Ela vai saber te explicar melhor!', order_id: casamento_pablo.id, user: pablo)
Message.create!(content: 'Olá Pedro, tudo bem?', order_id: festa_manikas.id, user: luis_f)
Message.create!(content: 'Percebi que cadarastou para nós um endereço para o evento, gostaria de saber o que já teria no local e o que precisariamos levar, de louça, utensílios...', order_id: festa_manikas.id, user: luis_f)
Message.create!(content: 'Oi Luis, bão?', order_id: festa_manikas.id, user: luis_f)
Message.create!(content: 'O endereço em questão é a casa que alugamos para as atividades da nossa empresa. Não possuimos nada de utensílios de cozinha.', order_id: festa_manikas.id, user: orochinho)
Message.create!(content: 'Vocês cobram valor adicional para trazer esses ítens pra cá?', order_id: festa_manikas.id, user: orochinho)
Message.create!(content: 'Nós temos diferentes sets de louças, para o set de louças padrão é cobrado um adicional simbólico de R$50.', order_id: festa_manikas.id, user: luis_f)
Message.create!(content: 'Se quiser, podemos agendar uma reunião para que eu te apresente as louças da casa!', order_id: festa_manikas.id, user: luis_f)
# Ratings
Rating.create!(score: 5, review: 'Achei hiper bacana.', buffet: felipe.buffet, user: felca)
Rating.create!(score: 5, review: 'Prometeram muito e entregaram! Adorei, com certeza voltarei a contratar.', buffet: felipe.buffet, user: julia)
Rating.create!(score: 4, review: 'Foi bacana, mas poderia ser melhor.', buffet: felipe.buffet, user: pablo)
rating = Rating.new(score: 4, review: 'Bem legal hehe.', buffet: felipe.buffet, user: orochinho)
rating.pictures.attach(io: File.open('app/assets/images/londrina_planalto.jpg'), filename: 'londrina_planalto.jpg')
rating.save
Rating.create!(score: 3, review: 'Não gostei da comida, achei sem graça.', buffet: antonia.buffet, user: pablo)

