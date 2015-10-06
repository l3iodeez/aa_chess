 class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8){ Array.new(8)}
    #call populate board to place all the pieces
  end

  def populate_black
    8.times do |i|
      self[[1,i]] = Pawn.new([1,i],self,:b)
    end
    [0,7].each do |i|
      self[[0,i]] = Rook.new([1,i],self,:b)
    end
    [1,6].each do |i|
      self[[0,i]] = Knight.new([1,i],self,:b)
    end
    [2,5].each do |i|
      self[[0,i]] = Bishop.new([1,i],self,:b)
    end
    self[[0,3]] = Queen.new([0,4],self,:b)
    self[[0,4]] = King.new([0,5],self, :b)

    nil
  end
  def populate_white
    8.times do |i|
      self[[6,i]] = Pawn.new([1,i],self,:w)
    end
    [0,7].each do |i|
      self[[7,i]] = Rook.new([1,i],self,:w)
    end
    [1,6].each do |i|
      self[[7,i]] = Knight.new([1,i],self,:w)
    end
    [2,5].each do |i|
      self[[7,i]] = Bishop.new([1,i],self,:w)
    end
    self[[7,4]] = Queen.new([0,4],self,:w)
    self[[7,3]] = King.new([0,5],self, :w)

    nil
  end

  def [](pos)
    x, y = pos
    return grid[x][y]
  end

  def []=(pos, set_value)
    x, y = pos
    grid[x][y] = set_value
  end

  def move(start_pos, end_pos)
    raise ArgumentError if self[start_pos] == nil
    raise ArgumentError if !self[start_pos].moves.include?(end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[end_pos].position = end_pos

  end

  def self.in_bounds?(pos)
    return false unless pos.first.between?(0, 7)
    return false unless pos.last.between?(0, 7)

    true
  end


end
