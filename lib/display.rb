require "./lib/cursorable"
require "./lib/board"
require "./lib/pieces"
require "colorize"

class Display
  attr_reader :board, :cursor_pos

  DISPLAY_VALUES = {
    nil => "   ".colorize( :background => :light_white),
    :pawn => " P ".colorize( :background => :light_white),
    :rook => " R ".colorize( :background => :light_white),
    :knight => " H ".colorize( :background => :light_white),
    :bishop => " B ".colorize( :background => :light_white),
    :king => " K ".colorize( :background => :light_white),
    :queen => " Q ".colorize( :background => :light_white),
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
      get_input

      render
    end



  end

  def render
    system('clear')
     board.grid.length.times {print "----"}
     puts
      board.grid.each_with_index do |row, rindex|
        print "|"
        row.each_with_index do |piece, pindex|
          pos = [rindex,pindex]
          print cursor(DISPLAY_VALUES[nil],pos) if piece.nil?
          print cursor(DISPLAY_VALUES[piece.type], pos) if !piece.nil?
          print DISPLAY_VALUES[:|]
        end
        puts
        board.grid.length.times {print "----"}
        puts
      end
  end

  def cursor(string, position)
    if position == cursor_pos
      return string.colorize( :background => :red)
    else
      return string
    end
  end






end
