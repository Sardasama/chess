# TODO :
# try to use modules or patterns for moves
# maybe include a Position object (in chesspieces too)

require_relative 'chesspieces'
require_relative 'game'

class Square
  attr_accessor :row, :col, :piece
  def initialize(r, c, piece = nil)
    @row = r
    @col = c
    @piece = piece
  end
  def isempty?
    @piece.nil?
  end
end

class Board
  attr_accessor :grid
  def initialize  
    @grid = [[],[],[],[],[],[],[],[]]
    for r in (0..7)
      for c in (0..7)
        case [r, c]
          when [0, 0]
          @grid[r][c] = Square.new(r, c, Tower.new("black", [0,0]))
          when [0, 1]
          @grid[r][c] = Square.new(r, c, Knight.new("black", [0,1]))
          when [0, 2]
          @grid[r][c] = Square.new(r, c, Bishop.new("black", [0,2]))
          when [0, 3]
          @grid[r][c] = Square.new(r, c, Queen.new("black", [0,3]))
          when [0, 4]
          @grid[r][c] = Square.new(r, c, King.new("black", [0,4]))
          when [0, 5]
          @grid[r][c] = Square.new(r, c, Bishop.new("black", [0,5]))
          when [0, 6]
          @grid[r][c] = Square.new(r, c, Knight.new("black", [0,6]))
          when [0, 7]
          @grid[r][c] = Square.new(r, c, Tower.new("black", [0,7]))
          when [7, 0]
          @grid[r][c] = Square.new(r, c, Tower.new("white", [7,0]))
          when [7, 1]
          @grid[r][c] = Square.new(r, c, Knight.new("white", [7,1]))
          when [7, 2]
          @grid[r][c] = Square.new(r, c, Bishop.new("white", [7,2]))
          when [7, 3]
          @grid[r][c] = Square.new(r, c, Queen.new("white", [7,3]))
          when [7, 4]
          @grid[r][c] = Square.new(r, c, King.new("white", [7,4]))
          when [7, 5]
          @grid[r][c] = Square.new(r, c, Bishop.new("white", [7,5]))
          when [7, 6]
          @grid[r][c] = Square.new(r, c, Knight.new("white", [7,6]))
          when [7, 7]
          @grid[r][c] = Square.new(r, c, Tower.new("white", [7,7]))
          else
            if r == 1
              @grid[r][c] = Square.new(r, c, Pawn.new("black", [1,c]))
            elsif r == 6
              @grid[r][c] = Square.new(r, c, Pawn.new("white", [6,c]))
            else
              @grid[r][c] = Square.new(r, c)
            end
        end
      end
    end
  end

  def move_piece(from, to, update)
    #if destination is empty
    if get_chesspiece(to).nil? || get_chesspiece(from).color != get_chesspiece(to).color 
      if get_chesspiece(from).is_move_valid?(to)
        if !check_pawn_move(from, to)
          puts "Invalid move, your chesspiece cannot perform that move."
          return false
        end
        if no_collision?(from, to)
          if update
            if !get_chesspiece(to).nil? && get_chesspiece(from).color != get_chesspiece(to).color 
              puts "The #{get_chesspiece(to).color} #{get_chesspiece(to).name} has been taken!"
            end
            get_chesspiece(from).move_to(to)
            @grid[to[0]][to[1]].piece = get_chesspiece(from)
            @grid[from[0]][from[1]].piece = nil
            if get_chesspiece(to).is_a?(Pawn) && (to[0] == 0 || to[0] == 7)
              promote_pawn(get_chesspiece(to))
            end
          end
          return true
        else
          puts "Invalid move : a pawn is in the way."
          return false
        end
      end
    # else this means get_chesspiece(from).color == get_chesspiece(to).color
    else 
      puts "Invalid move : the destination already contains one of your pawns." 
      return false
    end
  end

  def get_chesspiece(pos)
    @grid[pos[0]][pos[1]].piece
  end

  def check_pawn_move(from, to)
    if get_chesspiece(from).is_a?(Pawn) && diagonal_move?(from, to)
      if get_chesspiece(to).nil?
        return false
      end
      true
    else
      return true
    end
  end
  
  def no_collision?(from, to)
    if horizontal_move?(from, to)
      for i in (from[1]..to[1])
        if !@grid[from[0]][i].piece.nil? && [from[0], i] != from && [from[0], i] != to
           puts "#{get_chesspiece([from[0], i])} is in the way"
           return false
        end
      end
    end
    if vertical_move?(from, to)
      for i in (from[0]..to[0])
        if !@grid[i][from[1]].piece.nil? && [i, from[1]] != from && [i, from[1]] != to
          puts "#{get_chesspiece([i, from[1]])} is in the way"
          return false 
        end
      end
    end
    if diagonal_move?(from, to)
      for i in(1..7)
        p i
      # if SE move
        if to[0] > from[0] && to[1] > from[1]
          puts "SE move" if @debugmode
          return true if [from[0] + i, from[1] + i] == to
          if !@grid[from[0] + i][from[1] + i].piece.nil? 
            puts "#{get_chesspiece([from[0] + i, from[1] + i])} is in the way"
            return false
          end
      # if SW move
        elsif to[0] > from[0] && to[1] < from[1]
          puts "SW move" if @debugmode
          return true if [from[0] + i, from[1] - i] == to
          return false if !@grid[from[0] + i][from[1] - i].piece.nil?
      # if NW move
        elsif to[0] < from[0] && to[1] < from[1]
          puts "SW move" if @debugmode
          return true if [from[0] - i, from[1] - i] == to
          return false if !@grid[from[0] - i][from[1] - i].piece.nil?
      # if NE move
        else
          puts "NE move" if @debugmode
          return true if [from[0] - i, from[1] + i] == to
          return false if !@grid[from[0] - i][from[1] + i].piece.nil?
        end
      end
    end
    true
  end

  def promote_pawn(pawn)
    puts "Your pawn can be promoted !"
    input = "";
    until ["T", "K", "B", "Q"].include?(input)
      puts "Please select a promotion : (T)ower, (K)night, (B)ishop or (Q)ueen."
      input = gets.chomp 
    end
    r = pawn.position[0]
    c = pawn.position[1]

    case input
      when "T"
        new_piece = Tower.new(pawn.color, pawn.position)
      when "K"
        new_piece = Knight.new(pawn.color, pawn.position)
      when "B"
        new_piece = Bishop.new(pawn.color, pawn.position)
      when "Q"
        new_piece = Queen.new(pawn.color, pawn.position)
    end
    @grid[r][c] = Square.new(r, c, new_piece)
  end

  def horizontal_move?(from, to)
    return true if from[0] == to[0]
    puts "not an horizontal move" if @debugmode
    false
  end

  def vertical_move?(from, to)
    return true if from[1] == to[1]
    puts "not a vertical move" if @debugmode
    false
  end
  
  def diagonal_move?(from, to)
    for i in (-7..7)
       return true if from[0] + i == to[0] && from[1] + i == to[1]
       return true if from[0] + i == to[0] && from[1] - i == to[1]
    end
    puts "not an diagonal move" if @debugmode
    false
  end
  
  def show
    puts "\n"
    print "  |0 1 2 3 4 5 6 7 \n"
    print "-------------------\n"
    @grid.each_with_index do |row, idx|
      print "#{idx} |"
      row.each do |square| 
        print "#{square.piece.image.encode('utf-8')} " unless square.piece.nil?
        print "  " if square.piece.nil?
      end
      print "\n"
    end
    puts "\n"
  end
end
