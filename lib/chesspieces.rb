# TODO
# add rook move
# add first move option for pawns

class ChessPiece
  attr_accessor :name, :color, :image, :position

  def initialize(color, position)
    @color = color
    @position = position
    @move_map = []
  end
  
  def pos_hash(pos)
    hash = pos[0].to_s.concat(pos[1].to_s).to_i
    #p hash
  end
  
  def move_to(from_pos = @position, to_pos)
    puts "Your #{@name} was moved to #{to_pos}."
    @position = to_pos
    build_move_map
  end

  def is_move_valid?(from_pos = @position, to_pos)
    if !@move_map.include?(to_pos)
      puts "Invalid move, your chesspiece cannot perform that move."
      return false
    else
      return true
    end
  end
end

class Knight < ChessPiece
  attr_reader :name, :image
  
  def initialize(color, position)
    @name = "Knight"
    @image = color == "white" ? "\u2658" : "\u265E"
    super(color, position)
    build_move_map
  end
  
  def build_move_map
    r = @position[0]
    c = @position[1]
    @move_map = []
    @move_map << [r - 2, c - 1] unless r - 2 < 0 || c - 1 < 0
    @move_map << [r - 1, c - 2] unless r - 1 < 0 || c - 2 < 0
    @move_map << [r + 2, c + 1] unless r + 2 > 7 || c + 1 > 7
    @move_map << [r + 1, c + 2] unless r + 1 > 7 || c + 2 > 7
    @move_map << [r - 2, c + 1] unless r - 2 < 0 || c + 1 > 7
    @move_map << [r - 1, c + 2] unless r - 1 < 0 || c + 2 > 7
    @move_map << [r + 1, c - 2] unless r + 1 > 7 || c - 2 < 0
    @move_map << [r + 2, c - 1] unless r + 2 > 7 || c - 1 < 0
  end
end

class Tower < ChessPiece
  attr_reader :name, :image
  
  def initialize(color, position)
    @name = "Tower"
    @image = color == "white" ? "\u2656" : "\u265C"
    super(color, position)
    build_move_map
  end

  def build_move_map
    r = @position[0]
    c = @position[1]
    @move_map = []
    for i in (-7..7)
      @move_map << [r + i, c] unless r + i < 0 || r + i > 7
      @move_map << [r, c + i] unless c + i < 0 || c + i > 7
    end
  end
end

class Bishop < ChessPiece
  attr_reader :name, :image

  def initialize(color, position)
    @name = "Bishop"
    @image = color == "white" ? "\u2657" : "\u265D"
    super(color, position)
    build_move_map
  end

  def build_move_map
    r = @position[0]
    c = @position[1]
    @move_map = []
    for i in (-7..7)
      @move_map << [r + i, c + i] unless r + i < 0 || r + i > 7 || c + i < 0 || c + i > 7
    end 
  end
end

class Queen < ChessPiece
  attr_reader :name, :image

  def initialize(color, position)
    @name = "Queen"
    @image = color == "white" ? "\u2655" : "\u265B"
    super(color, position)
    build_move_map
  end

  def build_move_map
    r = @position[0]
    c = @position[1]
    @move_map = []
    for i in (-7..7)
      @move_map << [r + i, c] unless r + i < 0 || r + i > 7
      @move_map << [r, c + i] unless c + i < 0 || c + i > 7
      @move_map << [r + i, c + i] unless r + i < 0 || r + i > 7 || c + i < 0 || c + i > 7
      @move_map << [r + i, c - i] unless r + i < 0 || r + i > 7 || c - i < 0 || c - i > 7
    end 
  end
end

class King < ChessPiece
  attr_reader :name, :image

  def initialize(color, position)
    @name = "King"
    @image = color == "white" ? "\u2654" : "\u265A"
    super(color, position)
    build_move_map
  end

  def build_move_map
    r = @position[0]
    c = @position[1]
    @move_map = []
    for i in (-1..1)
      for j in (-1..1)
        @move_map << [r + i, c + j] unless r + i < 0 || r + i > 7 || c + j < 0 || c + j > 7
      end
    end  
  end
end

class Pawn < ChessPiece
  attr_reader :name, :image

  def initialize(color, position)
    @name = "Pawn"
    @image = color == "white" ? "\u2659" : "\u265F"
    super(color, position)
    build_move_map
    @color == "black" ? @move_map << [3, position[1]] :  @move_map << [4, position[1]]
  end

  def build_move_map
    r = @position[0]
    c = @position[1]
    @move_map = []
    if @color == "black"
      @move_map << [r + 1, c]  unless r + 1 > 7
      @move_map << [r + 1, c + 1]  unless r + 1 > 7 || c + 1 > 7
      @move_map << [r + 1, c - 1]  unless r + 1 > 7 || c - 1 < 0
    else
      @move_map << [r - 1, c]  unless r - 1 < 0
      @move_map << [r - 1, c + 1]  unless r - 1 < 0 || c + 1 > 7
      @move_map << [r - 1, c - 1]  unless r - 1 < 0 || c - 1 < 0
    end
  end
end
