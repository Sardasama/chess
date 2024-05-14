class Knight
  def initialize(pos = [0,1])
    @kpos = pos
    pos_hash(pos)
    build_pos_map
  end

  def build_pos_map
    @kmap = []
    for r in (0..7)
      for c in (0..7)
        @kmap[pos_hash([r,c])] = []
        build_marr(@kmap[pos_hash([r,c])], r, c)
      end
    end
  end

  def build_marr(mar, r, c)
    mar << [r - 2, c - 1] unless r - 2 < 0 || c - 1 < 0
    mar << [r - 1, c - 2] unless r - 1 < 0 || c - 2 < 0
    mar << [r + 2, c + 1] unless r + 2 > 7 || c + 1 > 7
    mar << [r + 1, c + 2] unless r + 1 > 7 || c + 2 > 7
    mar << [r - 2, c + 1] unless r - 2 < 0 || c + 1 > 7
    mar << [r - 1, c + 2] unless r - 1 < 0 || c + 2 > 7
    mar << [r + 1, c - 2] unless r + 1 > 7 || c - 2 < 0
    mar << [r + 2, c - 1] unless r + 2 > 7 || c - 1 < 0
  end

  def get_next_moves(pos = @kpos)
    @kmap[pos_hash(pos)].each { |m| yield m }
  end


  def knight_moves(from_pos = @kpos, to_pos)
    @nb_moves = 0
    @path = []
    queue = []
    if !to_pos[0].between?(0,7) || !to_pos[1].between?(0,7)
      raise StandardError.new "Invalid ending square"
    end
    unless from_pos == to_pos
      look_for_targetpos(from_pos, to_pos, queue)
    end
    puts "Your knight traveled to #{to_pos} in #{@nb_moves} moves !"
    puts "Here is your path : "
    p @path
  end

  def look_for_targetpos(current_pos, target_pos, queue)
    @nb_moves += 1
    #p current_pos
    @kmap[pos_hash(current_pos)].each do |next_move|
       queue << next_move
    end
    #p queue
    queue.each do |move|
      if move == target_pos
        @path.unshift(current_pos)
        return @nb_moves
      elsif move == queue.last
        look_for_targetpos(move, target_pos, queue)
      end
    end
  end
end

def pos_hash(pos)
  hash = pos[0].to_s.concat(pos[1].to_s).to_i
  #p hash
end

my_knight = Knight.new([4,5])

my_knight = Knight.new([0,1])
my_knight.knight_moves([8,2])
