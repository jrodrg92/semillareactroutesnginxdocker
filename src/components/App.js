import React from 'react';
import { BrowserRouter, Route , Switch } from 'react-router-dom';
import Button from './Button';

class App extends React.Component {

    constructor(props){
        super(props);
    }

    render(){
       return <BrowserRouter>
                    <Switch>
                        <Route path="/Button" component={Button} />

                    </Switch>
            </BrowserRouter>
    }
}

export default App