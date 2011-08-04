# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	if $('body').hasClass 'posts'
		# enable ajax submit on buttons and forms.
		$('div #new_comment').submitWithAjax()
		$('.button_to').submitWithAjax()
		
		# enables forms to be submit with CTRL+Enter
		$('form *').keypress (e) ->
			if ((e.which && e.which == 13 && e.ctrlKey) || (e.keyCode && e.keyCode == 13 && e.ctrlKey))
				$(this).parents('form').find('[type=submit]').eq(0).focusin().click()
				$(this).parents('form')[0].reset()
				return false
		# hide the submit button 
		$('form *').enableCtrlEnter()
		$('.formtastic.comment input.create').hide()
		
		# Show/hide comments.
		$('a.showComments').enableShowComments()
				
		# enable autogrow for all comment bodies.
		$('#comment_body').autogrow()