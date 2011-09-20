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
	constructor: (@id, @raph, @colour, @taken, @link) ->
		@raph.attr('fill', '#' + @colour)
		@raph.attr('stroke', '#333')
		@raph.hover((event) ->
			$('svg').append(this)   # max z-index for this element now (constrained to SVG ordering)
			s = this.animate({scale: '10'}, 500, 'bounce')
			this.animateWith(s, {stroke: '#fff'}, 300, 'backin')
		, (event) ->
			s = this.animate({stroke: '#333'}, 300, 'backin')
			this.animateWith(s, {scale: '1'}, 500, 'bounce')
		)
		@raph.click ->
			taken = if @taken then 'taken' else 'not taken'
			alert 'wohooo clicked on square number ' + @id + ' and it is ' + taken

drawMap = =>
	@paper = Raphael('loader', 725, 900)
	$('svg').hide()
	for square in squares
		do (square) ->
			raph_square = @paper.rect(square.x, square.y, square.width, square.height)
			@horn.push(new Square(square.id, raph_square, square.colour, square.taken))
	$('#loading').fadeOut(500)
	setTimeout("$('svg').fadeIn()", 500)