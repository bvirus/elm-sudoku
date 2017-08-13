const { join } = require('path');

module.exports = {
    entry: join(__dirname, "src", "sudoku.js"),
    output: {
        path: join(__dirname, "public"),
        filename: 'bundle.js'
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style-loader!css-loader" },
            { test: /\.jsx?$/, loader: 'babel-loader' }
        ]
    }
}