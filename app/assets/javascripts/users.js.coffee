# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	if $('body').hasClass 'users'
		# enable ajax submit on buttons and forms.
		$('div #new_comment').submitWithAjax()
		$("#new_post").submitWithAjax()
		$('.button_to').submitWithAjax()

		# enables forms to be submit with CTRL+Enter
		$('form *').keypress (e) ->
			if ((e.which && e.which == 13 && e.ctrlKey) || (e.keyCode && e.keyCode == 13 && e.ctrlKey))
				$(this).parents('form').find('[type=submit]').eq(0).focusin().click()
				$(this).parents('form')[0].reset()
				return false
		# hide the submit button 
		$('.formtastic.comment input.create').hide()
		
		# Show/hide comments.
		$('a.showComments').click ->
			commentable_id = $(@).attr('data-id')
			comments_div = $("div[data-commentable_id="+commentable_id+"]")
			if comments_div.is(":visible")
				comments_div.slideUp()
				false
			else
				comments_div.slideDown()
				false
		
		# loads more wall posts
		$("#load_more").click ->
			user_id = $("#load_more").attr('data-user_id')
			offset = parseInt($("#load_more").attr('data-offset'))
			offset += 10;
			$.getScript('../'+user_id+'/wall.js?offset='+offset+'')
			$("#load_more").attr('data-offset', offset)
			$("#load_more").text("Loading more...")
			false
				
		# enable autogrow for all comment bodies.
		$('#comment_body').autogrow()
	
		if $('body').hasClass 'livestream'
			$("#load_more").click ->
				user_id = $("#load_more").attr('data-user_id')
				offset = parseInt($("#load_more").attr('data-offset'))
				offset += 10;
				$.getScript('../'+user_id+'/livestream.js?offset='+offset+'')
				$("#load_more").attr('data-offset', offset)
				$("#load_more").text("Loading more...")
				false