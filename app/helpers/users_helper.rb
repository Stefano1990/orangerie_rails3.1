module UsersHelper
    # TODO Fix these helper methods.. very unorganised..
    # need to scan through project and make consistent use of the helper methods available.
    def current_user?(user)
      current_user == user
    end
    
    def is_friend?(user)
      Connection.connected?(user, current_user)
    end
    
    def user_avatar(options={})
      user = options[:user]
      size = options[:size]
      if user.avatar.nil?
        # this is only done for testing now.
        image_tag("/assets/stock/#{rand(7)+1}.png", :class => options[:class], :height => options[:resize], :width => options[:resize], :title => options[:user].name)
      else
        image_tag(user.avatar.image.url(size), :class => options[:class], :height => options[:resize], :width => options[:resize], :title => options[:user].name)
      end
    end
    
    def user_image_link(options={})
      raw %(#{link_to(user_avatar(:user => options[:user], :size => options[:size], :resize => options[:resize]), options[:user])})
    end
    
    def user_link(options={})
      user = options[:user]
      size = options[:size] || :small
      if options[:avatar]
        raw %(<div class="userlink">#{user_avatar(:user => user, :size => size, :resize => options[:resize])} #{link_to(user.name, user)}</div>)
      else
        link_to(user.name, user)
      end   
    end
    
    def friendsGrid(options={})
      raw %(#{link_to(user_avatar(:user => options[:user], :size => :small, :resize => "32px"), options[:user])})
    end
    
    def title
      # this should never happen.
      params[:action] != "unknown_action"
      
      case params[:controller]
        
      when "users"
        case params[:action]
      
        when "livestream"
          %(Livestream)
          
        when "show"
          %(Wall)
          
        when "infos"
          %(Infos)
          
        when "friends"
          %(Friends)
          
        when "photos"
          %(Fotos)
        end
        
      when "messages"
        case params[:action]
          
        when "index"
          t('users.messages.titles.inbox')
        when "show"
          t('users.messages.titles.show')
        when "reply"
          t('users.messages.titles.reply')
        when "new"
          t('users.messages.titles.new')
        when "sent"
          t('users.messages.titles.sent')
        when "trash"
          t('users.messages.titles.trash')
        end
      
      when "photos"
        case params[:action]
        when "index"
          t('users.photos.show_all')
        when "new"
          t('users.photos.new')
        when "show"
          t('users.photos.show', :album => @album.title)
        end
        
      when "albums"
        case params[:action]
        when "index"
          t('users.albums.show_all')
        when "new"
          t('users.albums.new')
        end
      end
    end

    
    def send_message_link(user, image=false)
      # makes a link to send a message to a user
      # if image = true, a little message icon is displayed
      user.infos.sex == "Couple" ? count = 2 : count = 1
      if image == true
        raw %(#{user_avatar :user => user, :size => :small, :resize => "30", :html => {:class => "avatar"}}
              #{link_to t('users.messages.send_me_a_message', :count => count), new_user_message_path(user)})
      else
        raw %(#{link_to user.name, new_user_message_path(user)})
      end
    end
    
    def smoking(state)
      if state == true
        I18n.t('general.yes')
      else
        I18n.t('general.noo')
      end
    end
    
    def sexual_pronoun(sex)
      case sex
        
      when "Mann"
        I18n.t('general.iii')
      when "Frau"
        I18n.t('general.iii')
      when "Paar"
        I18n.t('general.wee')
      end
    end
    
    def count(user)
      user.infos.sex == "Couple" ? count = 2 : count = 1
    end
    
    def user_infos(options={})
      title = 'users.infos.'+options[:att]
      @user.infos.sex == "Couple" ? count = 2 : count = 1
      unless @user.infos.send(options[:att]).empty?
        raw %(<div class="generalInfo">
                <table class="userInfos">
                  <tbody class="bigCategory">
      		        <tr>
        			      <th class="label">#{t(title, :count => count)}</th>
        			      <td class="data">#{simple_format @user.infos.send(options[:att]) }</td>
        		      </tr>
        		      <tr class="spacer"></tr>
    	            </tbody>
        	      </table>
        	    </div>)
      end
    end
    
    def user_infos_c(options={})
      att = options[:att]
      title = 'users.infos.'+att
      att_f = att+"_f"
      att_m = att+"_m"
  	  raw %(<tbody>
    		      <tr>
    			      <th class="label">#{t(title)}</th>
    			      <td class="data">#{@user.infos.send(att_f)}</td>
    			      <td class="data">#{@user.infos.send(att_m) }</td>
    		      </tr>
    	      </tbody>)
    end
    def user_infos_m(options={})
      att = options[:att]
      title = 'users.infos.'+att
      att_m = att+"_m"
      raw %(<tbody>
    		      <tr>
    			      <th class="label">#{t(title)}</th>
    			      <td class="data">#{@user.infos.send(att_m) }</td>
    		      </tr>
    	      </tbody>)
    end
    def user_infos_f(options={})
      att = options[:att]
      title = 'users.infos.'+att
      att_f = att+"_f"
      raw %(<tbody>
    		      <tr>
    			      <th class="label">#{t(title)}</th>
    			      <td class="data">#{@user.infos.send(att_f) }</td>
    		      </tr>
    	      </tbody>)
    end
end