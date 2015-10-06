 class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8){ Array.new(8)}
    #call populate board to place all the pieces
  end

  def populate_blue
    8.times do |i|
      self[[1,i]] = Pawn.new([1,i],self,:blue)
    end
    [0,7].each do |i|
      self[[0,i]] = Rook.new([0,i],self,:blue)
    end
    [1,6].each do |i|
      self[[0,i]] = Knight.new([0,i],self,:blue)
    end
    [2,5].each do |i|
      self[[0,i]] = Bishop.new([0,i],self,:blue)
    end
    self[[0,3]] = Queen.new([0,3],self,:blue)
    self[[0,4]] = King.new([0,4],self, :blue)

    nil
  end
  def populate_red
    8.times do |i|
      self[[6,i]] = Pawn.new([6,i],self,:red)
    end
    [0,7].each do |i|
      self[[7,i]] = Rook.new([7,i],self,:red)
    end
    [1,6].each do |i|
      self[[7,i]] = Knight.new([7,i],self,:red)
    end
    [2,5].each do |i|
      self[[7,i]] = Bishop.new([7,i],self,:red)
    end
    self[[7,4]] = Queen.new([7,4],self,:red)
    self[[7,3]] = King.new([7,3],self, :red)

    nil
  end

  def in_check(piece_color)
    enemy_pieces = grid.flatten.reject { |sq| sq.nil? || sq.color == piece_color }
    friendly_king = grid.flatten.select { |sq| sq.class == King && sq.color == piece_color }.first
  
    return enemy_pieces.any? {|piece| piece.moves.include?(friendly_king.position)}
    false
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
    raise ArgumentError.new "There is no piece at starting position #{start_pos}." if self[start_pos] == nil
    raise ArgumentError.new "The selected piece cannot move the position #{end_pos}." if !self[start_pos].moves.include?(end_pos)
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
