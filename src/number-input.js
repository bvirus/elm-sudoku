import React from 'react';

export class NumberInput extends React.Component {
    render() {
        return (<input ref={(input) => this.input = input } type="text"
            onChange={this.props.onChange}
            value={this.props.value || ""}
            onFocusCapture={this.props.onFocusCapture}
            />)
    }
    componentDidMount() {
        this.componentDidUpdate(this.props)
    }
    componentDidUpdate(props) {
        if (this.props.focused) 
            this.input.focus();
    }
}
