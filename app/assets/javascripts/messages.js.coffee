jQuery ->
	$("#message_recipient_tokens").tokenInput("/messages/recipients.json", {
		crossDomain: false,
		theme: "facebook",
		tokenLimit: "1",
		prePopulate: $("#message_recipient_tokens").data("pre")
	})
	# enable ajax submit
	$('#new_guestbook_message').submitWithAjax()
	$("#new_message").submitWithAjax();
	$('#message_content').autogrow();