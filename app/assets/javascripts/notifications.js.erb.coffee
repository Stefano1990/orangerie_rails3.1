# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	faye = new Faye.Client("10.0.1.7:9292/faye")
	user_id = $('#notifications').attr('data-user-id')
	channel = "/users/notifications/#{user_id}"
	faye.subscribe channel, (data) ->
	    eval(data)
		
	# cant get this fucker to work..
	#setInterval($.getScript('/notifications.js'), 5000)
	
	$("#show_notifications").click ->
		if $("#notifications").is(":visible")
			$("#notifications").slideUp()
			$("#notifications").children().hide()
			false
		else
			$("#notifications").children().show()
			$("#notifications").slideDown()
			false