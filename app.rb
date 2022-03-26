# frozen_string_literal: true

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
].freeze

class TicTacToe
  def initialize
    @players = Players.new
  end

  def start
    @count = 1
    @win = false
    @render = Board.new
    until @count == 10
      if @count.odd?
        turn(@players.p1, 'X')
      else
        turn(@players.p2, 'O')
      end
    end
  end

  def turn(player, symbol)
    puts "#{player}(#{symbol}) choose one available space"
    @move = gets.chomp.to_i - 1
    if (0..8).include?(@move) && @render.board[@move] == ' ' && @win == false
      @count += 1
      @render.update(@move, symbol)
      win_check
      tie_check
    else
      puts 'Puts an available position!'
    end
  end

  def win_check
    WIN_COMBINATIONS.each do |win_check|
      next unless @render.board[win_check[0]] == @render.board[win_check[1]] &&
                  @render.board[win_check[1]] == @render.board[win_check[2]] && @render.board[win_check[0]] != ' '

      case @render.board[win_check[0]]
      when 'X'
        puts "#{@players.p1} Wins!"
        @win = true
        @count = 10
      when 'O'
        puts "#{@players.p2} Wins!"
        @win = true
        @count = 10
      end
    end
  end

  def tie_check
    puts "It's a draw" if @count == 10 && @win == false
  end
end

class Players
  attr_accessor :p1, :p2

  def initialize
    puts 'Whats your name?'
    @p1 = gets.chomp.to_s.capitalize
    puts "Great #{@p1}, your symbol is 'X'"
    puts 'Whats your name player 2?'
    @p2 = gets.chomp.to_s.capitalize
    puts "Great #{@p2}, your symbol is 'O'"
  end
end

class Board
  attr_accessor :board

  def initialize
    puts 'Choose one of the available places(1-9):'
    puts ' 1 | 2 | 3 '
    puts '---+---+---'
    puts ' 4 | 5 | 6 '
    puts '---+---+---'
    puts ' 7 | 8 | 9 '
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def update(position, symbol)
    @board[position] = symbol
    render_board(@board)
  end

  def render_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]}"
    puts '---+---+---'
    puts " #{board[3]} | #{board[4]} | #{board[5]}"
    puts '---+---+---'
    puts " #{board[6]} | #{board[7]} | #{board[8]}"
  end
end

game = TicTacToe.new
game.start
