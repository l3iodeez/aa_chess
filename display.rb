require "./cursorable"
require "./board"

class Display

  DISPLAY_VALUES = {
    nil => " ",
    :pawn => "P",
    :rook => "R",
    :knight => "H",
    :bishop => "B",
    :king => "K",
    :queen => "Q"
  }

  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = false
  end

  def render
      board.each do |row|
        row.each do |piece|
          print DISPLAY_VALUES[nil] if piece.nil?
          print DISPLAY_VALUES[piece.type] if !piece.nil?

        end
        puts
      end

  end







end
