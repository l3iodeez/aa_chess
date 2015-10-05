require 'byebug'

class Piece
  attr_reader :board, :position, :color
  attr_writer :color

  def initialize(position, board, color)
    @position =  position
    @board = board
    @color = color
  end

end

class SlidingPieces < Piece

  def moves
    results = []

    self.class::MOVES.each do |k, v|
      current_pos = [position[0] + v[0], position[1] + v[1]]

      while Board.in_bounds?(current_pos) && (board[current_pos].nil? || board[current_pos].color != self.color)
        results << current_pos
        if current_pos == [0,5]
          debugger
        end
        break if !board[current_pos].nil?
        current_pos = [current_pos[0] + v[0], current_pos[1] + v[1]]

      end
      current_pos = position
    end

  results
  end

end

class Bishop < SlidingPieces
  MOVES = {
    upleft: [-1, -1],
    upright: [-1, 1],
    downleft: [1, -1],
    downright: [1, 1]
  }





end

class Queen < SlidingPieces
  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0],
    upleft: [-1, -1],
    upright: [-1, 1],
    downleft: [1, -1],
    downright: [1, 1]
  }

end

class Rook < SlidingPieces

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

end

class SteppingPieces < Piece

  def moves


  end

end

class Pawn < Piece

  def moves


  end

end
