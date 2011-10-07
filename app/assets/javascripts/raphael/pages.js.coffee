window.onload = ->
	s = document.createElement('script')
	s.type = 'text/javascript'
	s.async = true
	s.onreadystatechange = ->
		if this.readyState is 'complete'
			drawMap()
	s.onload = drawMap
	s.src = '/canvas_squares.js'
	x = document.getElementsByTagName('script')[0]
	x.parentNode.insertBefore(s, x)
	d_opts =
		apiKey: ENV['dailymotion']
	DM.init d_opts
	$('.overlay').click ->
		$(this).fadeOut()
	$('#refresh_dailymotion').click (e) ->
		e.preventDefault()
		$('#videos').html('')
		user = $('#username').val().replace(/^\s+|\s+$/g, '')
		DM.api '/user/' + user + '/videos', {limit: 5}, (response) ->
			if response && response.list
				for video in response.list
					DM.api "/video/#{video.id}", {fields: 'thumbnail_small_url,title,id,created_time,duration'}, (response) =>
						$('#videos').append "
							<div id=\"video_#{response.id}\" class=\"video\">
								<p>
									<a href=\"#\">
										<img src=\"#{response.thumbnail_small_url}\"/>
									</a>
								</p>
								<p>#{response.title}</p>
							</div>"
						$("#video_#{response.id} a").click (e) ->
							e.preventDefault()
							$('.video').removeClass('selected')
							$(this).find('img').addClass('selected')
							$('#dailymotion_id').val(response.id)
							DM.api "/video/#{video.id}", {fields: 'embed_html'}, (response) =>
								$('#video_embed_html').val(response.embed_html)

class Horn
	constructor: ->
	
	push: (square) ->
		@squares or= []
		@squares.push square

@horn = new Horn()

class Square
	constructor: (@paper, @x, @y, @width, @height, @id, @colour, @user_id, @user_name, @html, @dailymotion_id) ->
		id = @id
		square = this
		raph_square = @paper.rect(@x, @y, @width, @height)
		raph_square.attr {'fill': '#' + @colour, 'stroke': '#333'}
		@set = @paper.set raph_square
		@set.mouseover =>
			if !@zoomed
				raph_square.toFront()
				raph_square.animate({stroke: '#f00', 'stroke-width': 3}, 500, '<>')
		@set.mouseout (event) =>
			bb = @set.getBBox()
			e_x = event.x - $('svg').offset().left
			e_y = event.y - $('svg').offset().top + $(window).scrollTop()
			if !((bb.x + bb.width) >= e_x >= bb.x && (bb.y + bb.height) >= e_y >= bb.y)
				raph_square.animate({stroke: '#333', 'stroke-width': 1}, 500, '<>')
				raph_square.animate({width: @width, height: @height, x: @x, y: @y}, 500, 'bounce')
				@text.remove() if @text
				@zoomed = false
		raph_square.click =>
			if !@zoomed
				@zoomed = true
				raph_square.toFront()
				raph_square.animate({stroke: '#333'}, 200, '<>')
				s_x = if @x > 625 then 525 else (if @x-100 > 0 then @x-100 else 0)
				s_y = if @y > 800 then 700 else (if @y-100 > 0 then @y-100 else 0)
				stretch = raph_square.animate({width: 200, height: 200, x: s_x, y: s_y}, 500, 'bounce')
				@text = @paper.text(s_x+100, s_y+100, organise_text(squareText(@user_id, @user_name)))
				@text.click ->
					$('#square_id').val(id)
					square.expand()
				@set.push @text
				@text.attr {opacity: 0, 'font-family': 'Istok Web', 'font-size': 30}
				@text.animateWith(raph_square, stretch, {opacity: 1}, 500, '<>')
			else
				if !@user_id
					square.expand()
	
	expand: ->
		if canTake()
			overlay $("#overlay")
		else
			if @user_id && @html
				$('#author').text(@user_name)
				$("#video_iframe").html(@html)
				DM.api "/video/#{@dailymotion_id}", {fields: 'views_total'}, (response) =>
					$('#views').text(response.views_total)
				overlay $("#video_overlay")

drawMap = =>
	@paper = Raphael('loader', 725, 900)
	$('svg').hide()
	for square in squares
		do (square) ->
			@horn.push(new Square(@paper, square.x, square.y, square.width, square.height, square.id, square.colour, square.user_id, square.name, square.html, square.dailymotion_id))
	$('#loading').fadeOut(500)
	setTimeout("$('svg').fadeIn()", 500)

organise_text = (text) ->
	organised_text = []
	text_splits = text.split(' ')
	current_row = 0
	organised_text[0] = ''
	for chunk in text_splits
		if organised_text[current_row].length + chunk.length < 11
			organised_text[current_row] += " #{chunk}"
		else
			current_row += 1
			organised_text[current_row] or= ''
			organised_text[current_row] = chunk
	organised_text.join('\n')

pp = (object) ->
	alert JSON.stringify object

overlay = (div) ->
	div.fadeIn()
	div.find('.content').css 'top', ($(window).height()-div.find('.content').height())/2
	div.find('.content').css 'left', ($(window).width()-div.find('.content').width())/2