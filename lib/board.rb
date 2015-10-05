 class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8){ Array.new(8)}
    #call populate board to place all the pieces
  end
  def [](pos)
    x, y = pos
    return grid[x][y]
  end
  def []=(pos, set_value)
    x, y = pos
    grid[x][y] = set_value
  end
  def move(start_pos,end_pos)
    raise ArgumentError if self[start_pos] == nil
    raise ArgumentError if !valid_moves(start_pos).include?(end_pos)
    grid[end_pos] = grid[start_pos]
    grid[start_pos] = nil
  end

  def self.in_bounds?(pos)
    return false unless pos.first.between?(0,7)
    return false unless pos.last.between?(0,7)
    true

  end

  def potential_moves

  end
end
