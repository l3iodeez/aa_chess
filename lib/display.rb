require "./lib/cursorable"
require "./lib/board"
require "./lib/pieces"
require "colorize"
require "yaml"


class Display
  attr_reader :board, :cursor_pos
  attr_accessor :selected

  DISPLAY_VALUES = {
    NilClass => "   ",
    Pawn => " \u265F ".encode("utf-8"),
    Rook => " \u265C ".encode("utf-8"),
    Knight => " \u265E ".encode("utf-8"),
    Bishop => " \u265D ".encode("utf-8"),
    King => " \u265A ".encode("utf-8"),
    Queen => " \u265B ".encode("utf-8")
  }



  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = nil
  end

  def play
    until false
      play_turn
    end
  end

  def play_turn
      render
      board.move(*get_move)
  rescue ArgumentError => e
      puts e.message
  ensure
      self.selected = nil
  end

  def get_pos
    selected_pos = nil
    until selected_pos
      selected_pos = get_input
      render
    end
    selected_pos
  end


  def get_move
      start_pos = nil
      until start_pos && board[start_pos]
        start_pos = get_pos
      end

      self.selected = board[start_pos]

      end_pos = get_pos
      [start_pos, end_pos]
  end

  def render
    system('clear')
     puts
      board.grid.each_with_index do |row, rindex|
        row.each_with_index do |piece, pindex|
          pos = [rindex,pindex]
          print apply_color(pos)
        end
        puts
      end

      if selected.nil?
        puts "Select a piece."
      else
        puts "Moving #{selected.class.to_s} at #{selected.position}"
      end
    nil
  end

  def apply_color(position)
    piece_class = board[position].class

    board[position].nil? ? piece_color = nil : piece_color = board[position].color

    if piece_color == :red
      string = DISPLAY_VALUES[piece_class].colorize( :color => :light_red)
    elsif piece_color == :blue
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
# b.populate_blue
# b.populate_red
# d = Display.new(b)
# d.render



# b = YAML.load_file("check1.txt")
