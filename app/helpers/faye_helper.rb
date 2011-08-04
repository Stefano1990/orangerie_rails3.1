module FayeHelper
  LOCAL_URL = "http://10.0.1.7:9292"
  def enable_notifications
    raw %(<script type="text/javascript" charset="utf-8">
            $(function(){
    	        var faye = new Faye.Client("#{LOCAL_URL}/faye");
        	    faye.subscribe('/users/#{current_user.id}/notifications', function(data) {
        		    eval(data);
        	    });
        	  });
          </script>)
  end

  def enable_instant_messaging
    raw %(<script type="text/javascript" charset="utf-8">
            $(function(){
    	        var faye = new Faye.Client("#{LOCAL_URL}/faye");
        	    faye.subscribe('/users/#{current_user.id}/messages', function(data) {
        		    eval(data);
        	    });
        	  });
          </script>)
  end
  
  def enable_trusted_chat
    raw %(<script type="text/javascript" charset="utf-8">
            $(function(){
    	        var faye = new Faye.Client("#{LOCAL_URL}/faye");
        	    faye.subscribe('/chats/trusted', function(data) {
        		    eval(data);
        	    });
        	  });
          </script>)
  end
end