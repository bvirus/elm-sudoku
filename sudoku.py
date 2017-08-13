from board import Board

def advance(pos):
    (row, col) = pos
    col += 1
    if col >= 9:
        col = 0
        row += 1
    next = (row, col)
    return next


def solve(board, pos = (0, 0)):
    if pos[0] >= 9:
        return True
    
    if board.get(pos) != 0:
        return solve(board, advance(pos))

    for attempt in range(1, 10):
        if board.valid_move(pos, attempt):
            board.place(pos, attempt)
            if solve(board, advance(pos)):
                return True
            else:
                board.place(pos, 0)
    return False

def input_board():
    board = []
    for i in range(9):
        line = input()
        row = []
        for str in line.split(" "):
            num = int(str)
            row.append(num)
        board.append(row)
    return board

board = Board(input_board())
solve(board)
print()
print(board)
