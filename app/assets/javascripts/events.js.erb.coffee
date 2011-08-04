# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	if $('body').hasClass 'index'
		$(".short_description").hide() # hides the short_description <li>. this way peoiple withiout JS can still see it.
		# function to show the short_description li.
		$(".show_description").click ->
			id = $(this).attr('data-id')
			# checks if the event description is visible or not.
			if $('.short_description[data-id='+id+']').is(":visible")
				$('.short_description[data-id='+id+']').slideUp()
				$('.arrow').attr('src', '<%= image_path("ui/arrow_down.png")%>')
				false
			else
				$('.short_description[data-id='+id+']').slideDown()
				$('.arrow').attr('src', '<%= image_path("ui/arrow_up.png")%>')
				false
				
		# select box at the top submits a GET request.
		$("#series_id_name").change ->
			$.getScript("events.js?series_id="+$("select option:selected").attr("value"))
	
	if $('body').hasClass 'show'
		$('#invite_friends_window').jqm()
		
		# function so the user can click the whole <li> to select/disselect a friend.
		$(".friend").click ->
			id = $(this).attr('data-id')
			if $('input[type=checkbox][value='+id+']').prop("checked")
				$('input[type=checkbox][value='+id+']').prop("checked", false)
			else
				$('input[type=checkbox][value='+id+']').prop("checked", true)
		
		$("#new_reservation").hide()
		$("#showReservationForm").click ->
			$("#new_reservation").slideDown()
			return false;

		# word and letter counter for the remarks
		post_options = {
			maxCharacterSize: 160,
			displayFormat: ''
		}
		$('#reservation_remarks').textareaCount(post_options)
				
		# enables forms to be submit with CTRL+Enter
		$('form *').keypress (e) ->
				if ((e.which && e.which == 13 && e.ctrlKey) || (e.keyCode && e.keyCode == 13 && e.ctrlKey))
					$(this).parents('form').find('[type=submit]').eq(0).focusin().click()
					$(this).parents('form')[0].reset()
					return false
		# hide the submit button 
		$('.formtastic.comment input.create').hide()