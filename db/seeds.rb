# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'

	100.times do 
		a = Alt.new(                                 
			image_remote_url: Faker::Avatar.image(format: "jpg"),                        
			title: Faker::Hipster.sentence,                               
			original_url: Faker::Hipster.sentence,
			original_source: Faker::Hipster.sentence,
			verified: true,
			user_id: 1,
			body: Faker::Hipster.paragraphs(number: 2),
			tag_list: Faker::Hipster.sentence,
			check_performed: true,
			duplicate_check: true,
		)
	    a.image_derivatives!
	    a.image_attacher.add_metadata(caption: a.title, alt: a.body)
		@alt_text = AltText.new(body: a.body, user_id: 1, alt_id: a.id)
	    @alt_text.save
	    a.save
		puts a.image_url
	end

	100.times do 
		a = Alt.new(                                 
			image_remote_url: Faker::Avatar.image(format: "jpg"),                        
			title: Faker::Hipster.sentence,                               
			original_url: Faker::Hipster.sentence,
			original_source: Faker::Hipster.sentence,
			verified: false,
			user_id: 1,
			body: Faker::Hipster.paragraphs(number: 2),
			tag_list: Faker::Hipster.sentence,
			check_performed: true,
			duplicate_check: true,
		)
	    a.image_derivatives!
	    a.image_attacher.add_metadata(caption: a.title, alt: a.body)
		@alt_text = AltText.new(body: a.body, user_id: 1, alt_id: a.id)
	    @alt_text.save
	    a.save
		puts a.image_url
	end