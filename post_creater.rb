1000.times do
	user1 = User.find(rand(900)+1)
	contacts = user1.contacts
	unless contacts.empty?
		Post.create(:user_id => user1.id, :wall_id => contacts[rand(contacts.count)].id, :title => Faker::Lorem.sentence, :body => Faker::Lorem.paragraph)
	end
end