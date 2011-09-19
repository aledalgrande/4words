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
	
	getSquareAt: (x, y) ->
		found = null
		for square in @squares
			do (square) ->
				if square.x <= x && square.x + square.width >= x && square.y <= y && square.y + square.height >= y
					found = square
		return found
		
@horn = new Horn()

class Square
	constructor: (@id, @x, @y, @width, @height, @colour, @taken) ->

drawMap = =>
	canvas = document.getElementById("horn")
	context = canvas.getContext("2d")
	canvas.addEventListener("click", execute, false);
	for square in squares
		do (square) ->
			context.fillStyle = square.colour
			context.fillRect(square.x, square.y, square.width, square.height)
			@horn.push(new Square(square.id, square.x, square.y, square.width, square.height, square.colour, square.taken))
	$('#loading').fadeOut()
	$('#horn').fadeIn()

getMouseCoords = (event) ->
	if event.pageX != null && event.pageY != null
		x = event.pageX
		y = event.pageY
	else
		x = event.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
		y = event.clientY + document.body.scrollTop + document.documentElement.scrollTop
	canvas = document.getElementById("horn")
	x -= canvas.offsetLeft
	y -= canvas.offsetTop
	coords =
		x: x
		y: y

execute = (event) =>
	mouseCoords = getMouseCoords(event)
	if(mouseCoords == null)
		return
	alert 'Clicked on square number ' + @horn.getSquareAt(mouseCoords.x, mouseCoords.y).id
	# context.clearRect