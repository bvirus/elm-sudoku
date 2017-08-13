
class Position
    attr_reader :row
    attr_reader :col
    def initialize(row = 0, col = 0)
        @row = row
        @col = col
    end
end

class Board
    def initialize()
        @board = 9.times { }
    end
    def get(pos)
        return @board[pos.row][pos.col]
    end
    def place(pos, value)
        @board[pos.row][pos.col] = value
    end

    def [](pos)
        return self.get(pos)
    end

    def []=(pos, value)
        return self.place(pos, value)
    end
end

b = Board.new
pos = Position.new
b[pos] = 10
puts b[pos]