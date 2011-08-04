module CommentsHelper
  def delete_button(comment, commentable)
    if current_user?(comment.user) or current_user?(@user)
  	  button_to "X", comment_path(comment.id), 
   			              :method => :delete,
   					          :remote => true,
  					          :class => "destroy",
  					          :id => comment.id 
  	end
  end
  
  def time_in_words(comment)
    I18n.t('users.comments.created_ago',
  	 		:time => distance_of_time_in_words_to_now(comment.created_at))
  end
  
  #def livestream_who_on_whos(current_user, comment)
  #  case comment.commentable_type
  #    when "Post"
  #      #commentable_owner = commentable.owner # A wall post has a user (wrote it) and an owner (the wall it is on.)
  #      #commentable_user = commentable.user
  #      #
  #      #commentable_owner = urs
  #      #commentable_user = stefano
  #      #comment_user = urs
  #      #current_user = stefano
  #      
  #      if comment.user == comment.commentable.owner and current_user == comment.commentable.user
  #        "#{comment.user.name} commented on #{comment.commentable.user.name}'s post on #{comment.commentable.owner.name}'s wall"
  #      end
  #      if comment.user == comment.commentable.user
  #      end
  #    when "Event"
  #      # an event doesnt have a user.
  #    else
  #      commentable_user = commentable.user
  #  end
end
