require "./lib/cursorable"
require "./lib/board"
require "./lib/pieces"
require "colorize"

class Display
  attr_reader :board, :cursor_pos

  DISPLAY_VALUES = {
    NilClass => "   ",
    Pawn => " P ",
    Rook => " R ",
    Knight => " H ",
    Bishop => " B ",
    King => " K ",
    Queen => " Q ",
    :| => "|"
  }

  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = false
  end


  def play

    loop do
      render
      board.move(*get_move)
    end
  end

  def get_move
    start_pos = nil
      until start_pos && board[start_pos]
        start_pos = get_input
        render
        print start_pos
      end

    end_pos = nil
      until end_pos && board[start_pos].moves.include?(end_pos)
        end_pos = get_input
        render
      end
    print [start_pos, end_pos]
      [start_pos, end_pos]
  end

  def render
    system('clear')
     board.grid.length.times {print "----"}
     puts
      board.grid.each_with_index do |row, rindex|
        print "|"
        row.each_with_index do |piece, pindex|
          pos = [rindex,pindex]
          print apply_color(pos)
          print DISPLAY_VALUES[:|]
        end
        puts
        board.grid.length.times {print "----"}
        puts
      end
  end

  def apply_color(position)
    piece_class = board[position].class

    board[position].nil? ? piece_color = nil : piece_color = board[position].color

    if piece_color == :w
      string = DISPLAY_VALUES[piece_class].colorize( :color => :light_red)
    elsif piece_color == :b
      string = DISPLAY_VALUES[piece_class].colorize( :color => :light_blue)
    else
      string = DISPLAY_VALUES[piece_class]
    end
    unless (position.last.odd? && position.first.odd?) || (position.last.even? && position.first.even?)
      string = string.colorize(:background => :light_white)
    end

    if position == cursor_pos
      return string.colorize(:background => :light_black)
    else
      return string
    end
  end
end

# load './lib/display.rb'
# b = Board.new
# b.populate_black
# b.populate_white
# d = Display.new(b)
# d.render
