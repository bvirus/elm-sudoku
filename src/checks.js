function checkRow(board, row, attempt) {
    for (let i = 0; i < 9; i++) {
        if (board[row][i] === attempt) 
            return false;
    }
    return true;
}

function checkCol(board, col, attempt) {
    for (let i = 0; i < 9; i++) {
        if (board[i][col] === attempt) 
            return false;
    }
    return true;
}
function checkBox(board, row, col, attempt) {
    row = row - (row % 3)
    col = col - (col % 3)

    for (let i = 0; i <= 2; i++) {
        for (let j = 0; j <= 2; j++) {
            if (board[row+i][col+j] === attempt)
                return false;
        }
    }
    return true;
}

module.exports = {
    checkBox,
    checkCol,
    checkRow
}