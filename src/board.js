export function Board() {
    this._board = createBoard()
}
Board.prototype = {
    place: function(row, col, n) {
        this._board[row][col] = n;
    },
    get: function(row, col) {
        return this._board[row][col];
    }
}

export function createBoard() {
    let board = [];
    for (let i = 0; i < 9; i++) {
        let row = []
        for (let j = 0; j < 9; j++) {
            row.push(0);
        }
        board.push(row)
    }
    return board;
}

export function readBoard(str) {
    let lines = str.split('\n');
    let board = []
    for (let line of lines) {
        let nums = line.split(' ');
        let row = []
        for (let n of nums) {
            console.log(parseInt(n))
            row.push(parseInt(n))
        }
        board.push(row)
    }
    return board;
}

window.readBoard = readBoard;