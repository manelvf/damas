
console.log(window.screen.availWidth, window.screen.availHeight)


ROWLENGTH = 8

min = _.min([window.screen.availWidth, window.screen.availHeight])

s = Snap(min, min)
s.rect(0, 0, min, min)

squareSize = min/ROWLENGTH

class Cell
  constructor: (@x, @y) ->
    @tl = @getStep(@x-1, @y-1)
    @tr = @getStep(@x+1, @y-1)
    @bl = @getStep(@x-1, @y+1)
    @bt = @getStep(@x+1, @y+1)

  getStep: (x, y) ->
    a = @checkRowConstraints(x, 0, ROWLENGTH)
    b = @checkRowConstraints(y, 0, ROWLENGTH)
    if a and b then return [x,y]

  checkRowConstraints: (x, min, max) ->
    if x < min or x > max then false else true

class Board
  constructor: (@player1, @player2)->
    @cells = []
    @draw()
  addCell: (cell) ->
    @cells.push(cell)

  draw: (row=0, col=0) ->  # arguments are locals
    while row < ROWLENGTH
      col = 0
      while col < ROWLENGTH
        rect = s.rect(col*squareSize, row*squareSize, squareSize, squareSize)

        rect.attr(
          fill: if ((row*ROWLENGTH) + col + row)%2 then "#FF0000" else "#FFFFFF"
        )
        cell = new Cell(col, row)
        @addCell(cell)
        player1.checkDraw(cell)
    
        col += 1
      row += 1

class Piece
  constructor: (@x, @y) ->

  draw: () ->
  
class Player
  constructor: (@positions) ->
    @pieces = []

  checkDraw: (cell, elem=null) -> 
    console.log(@positions, (cell.y*ROWLENGTH) + cell.x)
    if @positions[(cell.y*ROWLENGTH) + cell.x]
       @pieces = new Piece(x, y)

       elem = s.circle(
         cell.x*squareSize + (squareSize/2),
         cell.y*squareSize + (squareSize/2),
         squareSize / 2
       )
       elem.attr
         fill: "#000000"

       elem.mousedown ->
         #console.log(arguments)

       elem.mousemove (e, x, y) ->
         if @oldx and @oldy
           @dx = x - @oldx
           @dy = y - @oldy
           @elem.animate({x:x, y:y}, 500)

         @oldx = x
         @oldy = y


player1 = new Player([
  0, 1, 0, 1, 0, 1, 0, 1,
  1, 0, 1, 0, 1, 0, 1, 0,
  0, 1, 0, 1, 0, 1, 0, 1,
])


init= () ->
  board = new Board(player1)

init()
