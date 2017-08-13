import { checkBox, checkCol, checkRow } from './checks';

export function advance(fc) {
    let next = fc.slice();
    next[1]++;
    if (next[1] >= 9) {
        next[1] = 0;
        next[0]++;
    }
    if (next[0] >= 9) {
        return false;
    }
    return next;
}

export function valid(board, row, col, attempt) {
    return checkRow(board, row, attempt) 
            && checkCol(board, col, attempt) 
            && checkBox(board, row, col, attempt);
}

export function solve(board, loc = [0, 0]) {
    if (loc === false) {
        return true;
    }
    
    const [ row, col ] = loc;
    if (board[row][col] !== 0)
        return solve(board, advance(loc))

    for (let attempt = 1; attempt <= 9; attempt++) {
        if (valid(board, row, col, attempt)) {
            board[row][col] = attempt;
            if (solve(board, advance(loc))) {
                return true;
            }
            board[row][col] = 0;
        }
    }
    return false;
}