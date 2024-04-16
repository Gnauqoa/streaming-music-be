# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

platform = Platform.create!(
  name: 'Streaming',
  client_id: "326ff5654b87fa2a31289ad03d7cb8e3"
)

user_0 = User.create!(first_name: 'Ika', last_name: 'of Company Agent', password: '123123123@q', email: 'user@streaming.com')

user_1 = User.create!(first_name: 'Mary', last_name: 'of Agent 1', password: '123123123@q', email: 'user1@streaming.com')

user_2 = User.create!(first_name: 'John', last_name: 'of Agent 2', password: '123123123@q', email: 'user2@streaming.com')

user_3 = User.create!(first_name: 'Jory', last_name: 'of Agent 3', password: '123123123@q', email: 'user3@streaming.com')

user_4 = User.create!(first_name: 'Mahn', last_name: 'of Agent 4', password: '123123123@q', email: 'user4@streaming.com')