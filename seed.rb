require 'faker'
require_relative 'database'
require_relative 'feedback'
require_relative 'post'
require_relative 'user'

ip_addresses = ['19.212.199.115',
                '25.244.73.115',
                '243.30.109.174',
                '42.189.221.142',
                '112.76.213.117',
                '66.195.11.50',
                '48.247.175.63',
                '70.246.252.57',
                '90.67.165.91',
                '7.90.162.114',
                '184.110.85.134',
                '171.253.198.131',
                '126.168.134.54',
                '180.36.228.129',
                '180.96.42.203',
                '222.92.94.68',
                '136.32.28.176',
                '119.155.253.207',
                '10.72.35.37',
                ]

20.times do |i|
	name = Faker::Name.unique.name
	user = User.insert_user(name)
	10.times do |i|
		title = Faker::Lorem.words
		content = Faker::Lorem.paragraphs
		post = Post.insert_post(title, content, ip_addresses.sample, user["id"].to_i)
		5.times do |i|
			id = Faker::Number.digit
			comment = Faker::Emotion.noun
			FeedBack.insert_feedback(id, comment, user["id"].to_i, post.first["id"].to_i)
		end
	end
end

#creating tables
User.create_user_table
Post.create_post_table
Rating.create_rating_table
FeedBack.create_feedback_table
