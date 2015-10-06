require "./lib/cursorable"
require "./lib/board"
require "./lib/pieces"
require "./lib/display"
require "colorize"
require "yaml"

class ChessGame
  attr_accessor :display, :board, :players, :current_player
  def initialize
    @board = Board.new
    board.populate_blue
    board.populate_red
    @display = Display.new(board, self)
    red_player = HumanPlayer.new(board, display, :red, self)
    blue_player = HumanPlayer.new(board, display, :blue, self)
    @players = [red_player, blue_player]
    @current_player = red_player
  end

  def switch_player!
    players.rotate!
    @current_player = players.first
  end

  def play_game
    until board.check_mate?(:red) || board.check_mate?(:blue)
      current_player.play_turn
    end
    display.render_board
    puts "Checkmate. #{current_player.color.to_s.capitalize} wins"
  end

end
class HumanPlayer
  attr_reader :game
  attr_accessor :board, :display, :color

  include Cursorable

  def initialize(board, display, color, game)
    @game = game
    @board = board
    @display = display
    @color = color
    @cursor_pos = [0,0]
    display.cursor_pos = @cursor_pos
  end
  def cursor_pos
      @cursor_pos
  end
  def cursor_pos=(pos)
    @cursor_pos = pos
    display.cursor_pos = pos
    game.players.reject {|player| player == self}.last.recieve_cursor_pos(pos)
  end

  def recieve_cursor_pos(pos)
    @cursor_pos = pos
  end


  def play_turn
      display.render
      board.move(*get_move, color)
      game.switch_player!
  rescue ArgumentError => e
      puts e.message
      sleep(1)
  ensure
      display.selected = nil
  end

  def get_pos
    selected_pos = nil
    until selected_pos
      display.render
      selected_pos = get_input
      display.render
    end
    selected_pos
  end


  def get_move
      start_pos = nil
      until start_pos && board[start_pos]
        start_pos = get_pos
      end

      display.selected = board[start_pos]

      end_pos = get_pos
      [start_pos, end_pos]
  end
end

if $PROGRAM_NAME == __FILE__
  game = ChessGame.new
  game.play_game
end
