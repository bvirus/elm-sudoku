let b = 
[4, 8, 0, 3, 2, 9, 0, 0, 0, 9, 2, 0, 6, 0, 0, 4, 3, 0, 0, 0, 0, 8, 0, 1, 0, 9, 7, 1, 6, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 3, 2, 6, 0, 1, 0, 7, 0, 0, 9, 0, 0, 0, 5, 0, 4, 8, 0, 5, 0, 0, 0, 3, 6, 0, 5, 2, 1, 3, 0, 0, 0, 0, 0, 3, 0, 6, 0, 9, 0, 2]

let blank = []

for (let i = 0; i < 81; i++)
blank.push(0);

function toRow(index) { return index - (index % 9)}
function toCol(index) { return index % 9; }
function boxStart(index) {
let col = toCol(index);
return (27 * Math.floor(index / 27)) + (col - (col % 3));
}

function getRow(index, board) {
return board.slice(toRow(index), toRow(index) + 8);
}

function getCol(index, board) {
return board.filter((item, i) => {
return toCol(i) === toCol(index);
})
}

function inBoxRow(start, i) {
return Math.floor(start/27) === Math.floor(i/27)
}

function inBox(start, i) {
let colDiff = toCol(i) - toCol(start);
return colDiff >= 0 && colDiff <= 2 && inBoxRow(start, i)
}

function getBox(index, board) {
let start = boxStart(index);
return board.filter((item, i) => {
return inBox(start, i)
})
}

function toSet(list) {
return new Set(list);

}

function checkList(list) {
list = list.filter(item => item !== 0);
return toSet(list).size === list.length;
}


function checkRow(index, board) {
return checkList(getRow(index, board))
}

function checkCol(index, board) {
return checkList(getCol(index, board))
}

function checkBox(index, board) {
return checkList(getBox(index, board))
}


function check(index, board) {
return checkRow(index, board) && checkCol(index, board) && checkBox(index, board)
}

function solve(board, index, attempt) {
if (index < board.length) {
  if (attempt >= 1 && attempt <= 9) {
    if (board[index] === 0) {
      let nextBoard = board.slice();
      nextBoard[index] = attempt;
      if (check(index, nextBoard)) {
        let [b, done] = solve(nextBoard, (index+1), 1)
        if (done) {
          return [b, done];
        } else return solve(board, index, (attempt + 1))
      } return solve(board, index, (attempt + 1))
    } else return solve(board, index+1, 1);
  } else return [board, false]
} else return [board, true]
}

console.log(solve(blank, 0, 1))