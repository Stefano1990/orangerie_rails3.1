500.times do 
  user1 = rand(900)+1
  user2 = rand(900)+1
  Connection.create(:user_id => user1, :contact_id => user2, :status => Connection::ACCEPTED, :accepted_at => Time.now )
  Connection.create(:user_id => user2, :contact_id => user1, :status => Connection::ACCEPTED, :accepted_at => Time.now )
end