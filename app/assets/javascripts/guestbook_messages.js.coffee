# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	# bind autogrow to the textbox.
	# This needs to be done BEFORE the form gets hidden. otherwise autogrow doesnt know its original size.
	$('#guestbook_message_body').autogrow()
	# Set up the max letter counter.
	message_options = 
		maxCharacterSize: 4000
		displayFormat: ''
	$('#guestbook_message_body').textareaCount(message_options)
	# enable ajax submit
	$('#new_guestbook_message').submitWithAjax()
	
	# Hides the guestbook form. This way also users without javascript can write something in the guestbook.
	$('#guestbook_message_form').hide()
	$('#show_guestbook_form').click ->
		$('#guestbook_message_form').slideDown()
		return false
	
	