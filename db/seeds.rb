# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
5.times do 
	Alt.create!(
	  	id: nil,                                  
		image_data: "{\"id\":\"198a294f218f56e747dd849bdbb1abd5.png\",\"storage\":\"store\",\"metadata\":{\"filename\":\"Screen Shot 2022-03-15 at 12.18.10 PM.png\",\"size\":1133376,\"mime_type\":\"image/png\",\"width\":1368,\"height\":906,\"caption\":\"Hope\",\"alt\":\"Hope\"},\"derivatives\":{\"small\":{\"id\":\"6b044b59832340d932472fd41fd12bc8.png\",\"storage\":\"store\",\"metadata\":{\"filename\":\"image_processing20220315-55055-zrshhj.png\",\"size\":320467,\"mime_type\":\"image/png\",\"width\":800,\"height\":530}}}}",                          
		title: Faker::Hipster.sentence,                               
		original_url: Faker::Hipster.sentence,
		original_source: Faker::Hipster.sentence,
		verified: true,
		user_id: 1,
		body: Faker::Hipster.paragraphs(number: 2),
		tag_list: Faker::Hipster.sentence
	)
end

5.times do 

	Alt.create!(
	  	id: nil,                                  
		image_data: "{\"id\":\"198a294f218f56e747dd849bdbb1abd5.png\",\"storage\":\"store\",\"metadata\":{\"filename\":\"Screen Shot 2022-03-15 at 12.18.10 PM.png\",\"size\":1133376,\"mime_type\":\"image/png\",\"width\":1368,\"height\":906,\"caption\":\"Hope\",\"alt\":\"Hope\"},\"derivatives\":{\"small\":{\"id\":\"6b044b59832340d932472fd41fd12bc8.png\",\"storage\":\"store\",\"metadata\":{\"filename\":\"image_processing20220315-55055-zrshhj.png\",\"size\":320467,\"mime_type\":\"image/png\",\"width\":800,\"height\":530}}}}",                          
		title: Faker::Hipster.sentence,                               
		original_url: Faker::Hipster.sentence,
		original_source: Faker::Hipster.sentence,
		verified: false,
		user_id: 1,
		body: Faker::Hipster.paragraphs(number: 2),
		tag_list: Faker::Hipster.sentence
	)
end

