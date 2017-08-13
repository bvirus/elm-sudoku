import { render } from 'react-dom';
import React, { Component, createElement } from 'react';

import { Board, createBoard } from './board';
import { advance, solve } from './solve';
import { NumberInput } from './number-input';

let focused = [0, 0]

class App extends Component {
    constructor(props, context) {
        super(props, context);
        let board = localStorage.getItem('board');
        if (!board) {
            board = createBoard()
        } else board = JSON.parse(board);
        this.state = {
            board: board,
            focus: [0, 0]
        }
        window.createBoard = createBoard;
    }
    render() {
        const { board, focus } = this.state;
        let buttons = [];

        for (let row = 0; row < 9; row++) {
            let r = []
            for (let col = 0; col < 9; col++) {
                let focused = (row === focus[0]) && (col === focus[1])
                
                r.push(<NumberInput key={row + " " + col}
                            value={board[row][col]}
                            focused={focused} 
                            onChange={ this.updateBoard.bind(this, row, col) } 
                            onFocusCapture={ this.focus.bind(this, row, col) }/>)
            }
            buttons.push(<div key={row}>{r}</div>);
        }

        return (
            <section title="app">
                <div>
                    <button onClick={this.solve.bind(this)}>Solve puzzle</button>
                    <button onClick={this.clear.bind(this)}>Clear</button>
                </div>
                <div className="grid">
                    {buttons}
                </div>
            </section>
        );
    }

    focus(row, col) {
        this.setState({
            focus: [row, col]
        })
    }
    
    updateBoard(row, col, ev) {
        let b = this.state.board.slice();
        let focus = this.state.focus;

        b[row][col] = parseInt(ev.target.value) || 0;

        if (!isNaN(parseInt(ev.target.value))) {
            focus = advance([row, col]) || [-1, -1]
        }

        if (b[row][col] >= 0 && b[row][col] <= 9) {
            this.setState({
                board: b,
                focus: focus
            });
            localStorage.setItem('board', JSON.stringify(b))
        }
    }

    solve() {
        let { board } = this.state;
        let b = board.slice();
        if (solve(b)) {
            this.setState({
                board: b
            })
        }
    }

    clear() {
        this.setState({
            board: createBoard(),
            focus: [0, 0]
        });
        localStorage.removeItem('board');
    }
}

render(<App />, document.querySelector("#app"));