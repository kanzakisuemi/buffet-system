# Cadê Buffet?
TreinaDev 12 - Campus Code
## 🧭 Description
Cadê Buffet? is a web application that connects users with a variety of buffets and event types available for hire. Users can browse through a curated selection of buffets and event options, making it easy to find the perfect fit for their needs.
Built on Ruby on Rails framework, Cadê Buffet? follows the Test-Driven Development (TDD) methodology to ensure consistensy and reliability. The application allows both guests and registered users to explore buffet listings and event types. However, to place bids or inquire about a specific buffet, users must first create an account and log in.

## 📂 Features
+ **User registration:** There are two user roles in this application:
  + **Business Owner** should own a buffet. A business owner can not fully complete the account registration before registering a buffet. A business owner is not allowed to register another buffet within the same account. 
  + **Client** should register a social security number to complete their registration. Client can search, hire, see details of all available buffets and rate previously hired buffets.
+ **Buffet Management:** the buffet's info can be updated by the associated business owner, who can also archive buffets.
  + archived buffets are not visible in the buffet listing, and its details are only accessible to the associated business owner. 
+ **Buffet listing:** both authenticated users and visitors can access the buffet listing which includes all unarchived buffets.
+ **Buffet search:** both authenticated users and visitors are able to search a buffet either by social name, city and event name.
+ **Bufet Rating:** is visible on the buffet's details page. The rating consists on a score and a review message, there might be pictures associated.
+ **Event type management:** business owners can register and update event types, which will be associated to the business owner's buffet. Event types can have multiple images attached.
+ **Event type listing:** event type listing is accessible through a buffet's details page.
+ **Order placement:** a client can place an order through a buffet's details page, where the event type is also specified.
+ **Payment methods:** this resource is set by the system and can be associated to multiple buffets.
+ **Chat:** A business owner can start a chat with a client through an order, meaning the same pair of users can have multiple chats through different orders.
## ⚙️ Dependencies
![Yarn](https://img.shields.io/badge/yarn-%232C8EBB.svg?style=for-the-badge&logo=yarn&logoColor=white)
![NPM](https://img.shields.io/badge/NPM-%23CB3837.svg?style=for-the-badge&logo=npm&logoColor=white)

![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-A10E3B?style=for-the-badge&logo=rubyonrails&logoColor=white)
![html](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![Bootstrap](https://img.shields.io/badge/bootstrap-%238511FA.svg?style=for-the-badge&logo=bootstrap&logoColor=white)
![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
![SASS](https://img.shields.io/badge/SASS-hotpink.svg?style=for-the-badge&logo=SASS&logoColor=white)

- ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)

  - **v 3.1.2**

- ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)

  - **v 7.0.8.1**


**GEMS**
- devise
- rspec-rails
- capybara
- jquery-rails
- cpf_cnpj
- turbo-rails
- stimulus-rails
- jsbundling-rails
- cssbundling-rails

## 🚀 Set Up
* remember to ```npm install --global yarn```

Clone this repository

```bash
git clone git@github.com:kanzakisuemi/buffet-system.git
```

Then run

```bash
bundle install
```

```bash
rails db:setup
```

Then run
```bash
rake assets:precompile
```
which will compile js and css files

Start the server

```bash
rails s
```

Access through

```
http://localhost:3000
```

**To login as:**
+ **Client** use the following credentials: email:  ```kanzaki@myself.com``` password: ```password123```
+ **Business owner** use the following credentials: email:  ```felipe@mail.com``` password: ```password123```

### Testing

Run

```
rspec
```


## Cadê Buffet? API
### Introduction
Welcome to Cade Buffet? API's doc.
See our available resources and learn how to consume them with HTTP requests.
### Authentication
This is an Open Source API. Authentication is not required for further queries.
### Encodings
Cade Buffet? provides only one encoding for you to render the data, which is **JSON**.
### Resources
**Buffets**

We call Buffets, the catering companies.

**Endpoints**

+ `/api/v1/buffets/`-- get all the buffet resources
+ `/api/v1/buffet/:id/`-- get a specific buffet resource
+ `/api/v1/buffets?search=example`-- search for a buffet's social name

**Example request:**
```
http http://localhost:3000/api/v1/buffets/1/
```
**Example response:**
```
HTTP/1.0 200 OK
Content-Type: application/json
{
  "id": 1,
  "social_name": "Planalto",
  "phone": "4333385038",
  "email": "contato@planalto.com",
  "address": "Av. Tiradentes, 6429",
  "neighborhood": "Parque Ney Braga",
  "city": "Londrina",
  "state": "PR",
  "zip_code": "86072000",
  "description": "Buffet para festas grandes e chiques.",
  "events_per_day": 1
}
```
**Attributes**
+ `id` integer -- the unique identifier for this Buffet
+ `social_name` string -- the socially used name of this Buffet
+ `phone` string -- the phone number to contact this Buffet
+ `email` string -- the email address to contact this Buffet
+ `address` string -- the full address (street and building number) of this Buffet
+ `neighborhood` string -- the name of the neighborhood the Buffet is located
+ `city` string -- the name of the city of the Buffet's location
+ `state` string -- the state code (uppercase and 2 chars)
+ `zip_code` string -- the zip/postal code of the Buffet's location
+ `description` string -- a brief description of the Buffet and its offerings
+ `events_per_day` integer -- the maximum number of events this Buffet can host per day

**Event Types**

We call Event Types, the variety of events a Buffet can cater.

**Endpoints**

+ `/api/v1/buffet/:id/event_types/`-- get all the event type resources, from a specific buffet
+ `/api/v1/event_types/:id/available?`-- check availability for an event on a specific date w/ certain guests amount
  - `params: { order: { event_type_id: integer, event_date: date, guests_estimation: integer } }` 

**Example request:**
```
http http://localhost:3000/api/v1/buffets/1/event_types/
```
**Example response:**
```
HTTP/1.0 200 OK
Content-Type: application/json
[
  {
    "id": 2,
    "category": "birthday",
    "name": "Aniversários de Casamento",
    "description": "Festa de Bodas e Renovação de Votos.",
    "minimal_people_capacity": 150,
    "maximal_people_capacity": 230,
    "default_duration_minutes": 180,
    "food_menu":"Entrada: Camarão Empanado. Prato principal: Refeição Surpresa. Sobremesa: Gelatto.",
    "alcoholic_drinks": true,
    "decoration": true,
    "parking_service": true,
    "location_flexibility": false,
    "buffet_id": 1,
    "base_price": "9000.0",
    "weekend_fee": 10,
    "per_person_fee": "70.0",
    "per_person_weekend_fee": 20,
    "per_hour_fee": "400.0",
    "per_hour_weekend_fee": 50
  },
  {
    "id": 1,
    "category": "wedding",
    "name": "Casamento de Luxo",
    "description": "Casamento para casais de alto padrão.",
    "minimal_people_capacity": 200,
    "maximal_people_capacity": 400,
    "default_duration_minutes": 300,
    "food_menu": "Entrada: Camarão Empanado. Prato principal: Risoto de Cogumelos. Sobremesa: Tiramisu.",
    "alcoholic_drinks": true,
    "decoration": true,
    "parking_service": true,
    "location_flexibility": false,
    "buffet_id": 1,
    "base_price": "15000.0",
    "weekend_fee": 20,
    "per_person_fee": "70.0",
    "per_person_weekend_fee": 20,
    "per_hour_fee": "400.0",
    "per_hour_weekend_fee": 50
  }
]
```
**Attributes**
+ `id` integer -- the unique identifier for this Event Type
+ `category` integer(enum) -- the category of the event (e.g. wedding, birthday)
+ `name` string -- the name of the Event Type
+ `description` string -- a description of the Event Type
+ `minimal_people_capacity` integer -- the minimum guaranteed number of people for this Event Type (if the actual number of guests is less than the minimum, you will still be charged based on the minimum)
+ `maximal_people_capacity` integer -- the maximum number of people this Event Type can accommodate (you cannot invite more guests than the Buffet's capacity)
+ `default_duration_minutes` integer -- the default duration of the event in minutes
+ `food_menu` string -- the food menu for this Event Type
+ `alcoholic_drinks` boolean -- indicates if alcoholic drinks are available
+ `decoration` boolean -- indicates if decoration is included
+ `parking_service` boolean -- indicates if parking service is available
+ `location_flexibility` boolean -- indicates if there is flexibility in choosing the location
+ `buffet_id` integer -- the identifier of the associated Buffet
+ `base_price` float -- the base price for this Event Type
+ `weekend_fee` integer -- the additional percentage fee for events on weekends
+ `per_person_fee` float -- the fee per person
+ `per_person_weekend_fee` integer -- the additional percentage fee per person for weekend events
+ `per_hour_fee` float -- the fee per hour
+ `per_hour_weekend_fee` integer -- the additional percentage fee per hour for weekend events
  
