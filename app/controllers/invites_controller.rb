class InvitesController < ApplicationController
  def invite_friends
    @invitable = find_invitable
    
    if Invite.invite_friends(@invitable, current_user, params[:friend_ids])
      flash[:success] = "You have invited your friends."
      redirect_to :back
    else
      flash[:error] = "Something didnt work.."
      redirect_to :back
    end
  end
  
  private
      def find_invitable
        params.each do |name, value|
          if name =~ /(.+)_id$/
            return $1.classify.constantize.find(value)
          end
        end
        nil
      end
end
