module ApplicationHelper  
  def title
    base_title = "Orangerie Le Club"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title} | Swingerclub Fun Sauna Restaurant"
    end
  end

  def user_is_admin?
    current_user.admin
  end
  
  def notify(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end