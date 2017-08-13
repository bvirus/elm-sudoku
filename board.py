# board.py
        
def default_board():
    board = [[0 for x in range(9)] for x in range(9)]

class Board:
    def __init__(self, board = default_board()):
        self.board = board
    def __iter__(self):
        return self.board

    def __str__(self):
        st = ""
        for row in range(9):
            s = ""
            for col in range(9):
                s += str(self.get((row, col))) + " "
            st += s.strip() + "\n"
        return st.strip()

    def place(self, pos, value):
        self.board[pos[0]][pos[1]] = value

    def get(self, pos):
        if pos[0] >= 9 or pos[1] >= 9 or pos[0] < 0 or pos[1] < 0:
            return -1
        else:
            return self.board[pos[0]][pos[1]]
        
    def valid_row(self, pos, attempt):
        row = pos[0]
        for col in range(9):
            if self.get((row, col)) == attempt:
                return False
        return True

    def valid_col(self, pos, attempt):
        col = pos[1]
        for row in range(9):
            if self.get((row, col)) == attempt:
                return False
        return True
        
    def valid_square(self, pos, attempt):
        (row, col) = pos
        row = row - (row % 3)
        col = col - (col % 3)
    
        for i in range(3):
            for j in range(3):
                if self.get(((row+i), (col+j))) == attempt:
                    return False
        return True

    def valid_move(self, pos, attempt):
        return self.valid_row(pos, attempt) \
            and self.valid_col(pos, attempt) \
            and self.valid_square(pos, attempt)

