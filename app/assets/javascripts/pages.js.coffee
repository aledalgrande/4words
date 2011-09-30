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

class Horn
	constructor: ->
	
	push: (square) ->
		@squares or= []
		@squares.push square

@horn = new Horn()

class Square
	constructor: (@paper, @x, @y, @width, @height, @id, @colour, @user_id, @link, @animated) ->
		raph_square = @paper.rect(@x, @y, @width, @height)
		raph_square.attr({'fill': '#' + @colour, 'stroke': '#333'})
		raph_square.mouseover (event) =>
			$('svg').append(raph_square)
			raph_square.animate({stroke: '#f00', 'stroke-width': 3}, 500, '<>')
		raph_square.mouseout (event) =>
			raph_square.animate({stroke: '#333', 'stroke-width': 1}, 500, '<>')
			raph_square.animate({width: @width, height: @height, x: @x, y: @y}, 500, 'bounce')
		raph_square.click =>
			$('svg').append(raph_square)   # max z-index for this element now (constrained to SVG ordering)
			raph_square.animate({stroke: '#333'}, 500, '<>')
			s_x = if @x > 625 then 525 else (if @x-100 > 0 then @x-100 else 0)
			s_y = if @y > 800 then 700 else (if @y-100 > 0 then @y-100 else 0)
			raph_square.animate({width: 200, height: 200, x: s_x, y: s_y}, 500, 'bounce')
			checkSquare(@colour)

drawMap = =>
	@paper = Raphael('loader', 725, 900)
	$('svg').hide()
	for square in squares
		do (square) ->
			@horn.push(new Square(@paper, square.x, square.y, square.width, square.height, square.id, square.colour, square.user_id))
	$('#loading').fadeOut(500)
	setTimeout("$('svg').fadeIn()", 500)