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
		apiKey: 'd02466c27526046aeb4c'
	DM.init d_opts
	$('.overlay').click ->
		$(this).fadeOut()
		$("#video_iframe").html('')
	$('.content').click (e) ->
		e.stopPropagation()
	$('#refresh_dailymotion').click (e) ->
		e.preventDefault()
		$('#videos').html('<img src="assets/ajax-loader.gif" />')
		user = $('#username').val().replace(/^\s+|\s+$/g, '')
		DM.api '/user/' + user + '/videos', {limit: 5}, (response) ->
			$('#videos').html('')
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
	$('#instructions').hover(-> 
		@inst = {height: $(this).height(), width: $(this).width(), font: $(this).css('fontSize'), h2: $(this).find('h2').css('fontSize'), h2l: $(this).find('h2').css('lineHeight')}
		$(this).animate({width: '+=100', height: '+=200', fontSize: '18px', paddingLeft: '10px'}, 500)
		$(this).find('h2').animate({fontSize: '24px', lineHeight: '30px'}, 500)
	, ->
		$(this).animate({width: @inst.width, height: @inst.height, fontSize: @inst.font, paddingLeft: '0px'}, 500)
		$(this).find('h2').animate({fontSize: @inst.h2, lineHeight: @inst.lineHeight}, 500)
	)
	$('#like').click (e) ->
		e.preventDefault()
		$.post '/votes', {video_id: $('#video_id').text().replace(/^\s+|\s+$/g, '')}, (data) ->
			$(this).parent().html('Liked!')
		, 'json'
	$('#report').click (e) ->
		e.preventDefault()
		$.post '/reports', {video_id: $('#video_id').text().replace(/^\s+|\s+$/g, '')}, (data) ->
			$(this).parent().html('Reported!')
		, 'json'

class Horn
	constructor: ->
	
	push: (square) ->
		@squares or= []
		@squares.push square

@horn = new Horn()

class Square
	constructor: (@paper, @x, @y, @width, @height, @id, @user_id, @user_name, @html, @dailymotion_id) ->
		@colour = if @user_id? then 'FFFFFF' else '808285'
		@opacity = if @user_id? then 0.1 else 0.85
		id = @id
		square = this
		image = @paper.image('/assets/african-kids.jpg', 0, 0, 725, 900)
		image.attr({ "clip-rect": "#{@x},#{@y},#{@width},#{@height}"})
		raph_square = @paper.rect(@x, @y, @width, @height)
		raph_square.attr {'fill': '#' + @colour, 'stroke': '#333', 'opacity': @opacity}
		@set = @paper.set raph_square
		@set.mouseover =>
			if !@zoomed
				raph_square.toFront()
				raph_square.attr 'opacity', 0.9
				raph_square.animate({stroke: '#f00', 'stroke-width': 3}, 500, '<>')
		@set.mouseout (event) =>
			bb = @set.getBBox()
			e_x = event.x - $('svg').offset().left
			e_y = event.y - $('svg').offset().top + $(window).scrollTop()
			if !((bb.x + bb.width) >= e_x >= bb.x && (bb.y + bb.height) >= e_y >= bb.y)
				raph_square.animate({stroke: '#333', 'stroke-width': 1}, 500, '<>')
				raph_square.animate({width: @width, height: @height, x: @x, y: @y}, 500, 'bounce')
				@text.remove() if @text
				raph_square.attr 'opacity', @opacity
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
		if canTake() && !@user_id
			overlay $("#overlay")
		else
			if @user_id
				$('#author').text(@user_name)
				if @html
					$("#video_id").text(@dailymotion_id)
					$("#video_iframe").html(@html)
					$('#video_meta').show()
					DM.api "/video/#{@dailymotion_id}", {fields: 'views_total'}, (response) =>
						$('#views').text(response.views_total)
				else
					$('#video_meta').hide()
				if @user_id == parseInt($('#user_id').text().replace(/^\s+|\s+$/g, ''))
					$('#video_actions').show()
				else
					$('#video_actions').hide()
				overlay $("#video_overlay")

drawMap = =>
	@paper = Raphael('loader', 725, 900)
	$('svg').hide()
	for square in squares
		do (square) ->
			@horn.push(new Square(@paper, square.x, square.y, square.w, square.h, square.id, square.u, square.n, square.k, square.d))
	$('#loading').fadeOut(500)
	setTimeout("$('svg').show()", 500)
	setTimeout("$('#africa').show()", 500)

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