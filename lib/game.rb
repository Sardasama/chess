# TODO : 
# add save/load game
# add winning conditions

require_relative 'board'

class Player
  attr_accessor :name, :color, :score
  def initialize(number, name = "Player 1", color)
    @name = name
    @color = color
    @score = 0
  end
end


class Game
  attr_accessor :debugmode, :end_game

  def initialize
    @debugmode = true
    @myboard = Board.new
    @end_game = false
    @player1 = Player.new(1, "Bob", "black")
    @player2 = Player.new(2, "John", "white")
    @players = [@player1, @player2]
  end

  def start
    puts "New Chess game started !"
    puts "\n"
    @players.each { |p| puts "#{p.name}, you will be playing with the #{p.color} pawns."}
    @myboard.show

    while !end_game
      @players.each do |p|
        is_move_ok = false
        until is_move_ok
          is_move_ok = true
          puts "Please #{p.name}, enter your move (1,3 2,3 for instance)"
          input = ""
          input = gets.chomp until is_input_format_valid?(input)
          from = get_from(input)
          to = get_to(input)
          if @myboard.get_chesspiece(from).nil?
            puts "No chesspiece here. Please select another." 
            is_move_ok = false
          end
          if is_move_ok && @myboard.get_chesspiece(from).color != p.color
            puts "Not yours ! Please select another."
            is_move_ok = false
          end
          if is_move_ok && !@myboard.move_piece(from, to, false)
            is_move_ok = false
          end
        end
        @myboard.move_piece(from, to, true)
        @myboard.show
      end
    end
  end

  def get_from(input)
    return [input[0].to_i, input[2].to_i]
  end

  def get_to(input)
    return [input[4].to_i, input[6].to_i]
  end

  def is_input_format_valid?(input)
    if /\d.\d.\d.\d/.match?(input)
      return true
    else
      puts "Move format doesnt match #,# #,#, try again" unless input == ""
      return false
    end
  end
end

