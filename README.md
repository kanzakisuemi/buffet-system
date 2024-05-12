## Cade Buffet?
### Version
ruby "3.1.2"
### Set Up
This app is using [Yarn](https://classic.yarnpkg.com/en/docs/getting-started)
https://classic.yarnpkg.com/en/docs/getting-started
```
bin/setup
rake assets:precompile
```
## Cade Buffet? API
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
  
