game_provider_1 = GameProvider.create!(name: 'Kplay',
                                       secret_key: 'H2Vdkj6tYMoDWzhDDEInILp8GDFVV6Hh',
                                       ag_code: "ZENNK01",
                                       ag_token: "URIfTiyHh4OQmMj4gYt7gy2gNA338wIW",
                                       provider_type: "kplay",
                                       endpoint: "http://uat.uplayone.com")
game_provider_2 = GameProvider.create!(name: 'Lotto',
                                       secret_key: '5d6aeddd741f0b5ddf0f780e50f76ddb',
                                       ag_code: "LOTTO",
                                       ag_token: "56e8d11d8e07844bef9e622a312fb10c",
                                       provider_type: "lotto",
                                       endpoint: "https://be.our-projects.org/v1/merchants")

Game.create!(
  name: 'Lotto',
  game_provider_id: game_provider_2.id,
  kplay_product_id: 1,
)
[["Evolution", 0],
 ["Black Jack", 1],
 ["Money Wheel", 2],
 ["Roulette Lightning", 3],
 ["Roulette European", 4],
 ["Megaball", 5],
 ["Dragon Tiger", 6],
 ["Baccarat", 7],
 ["TopCard", 8]].each do |game|
   Game.create!(
     name: game[0],
     game_provider_id: game_provider_1.id,
     kplay_product_id: 1,
     kplay_type: game[1],
   )
 end
