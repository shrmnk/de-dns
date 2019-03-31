import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Navbar from './components/layout/Navbar';
import Footer from './components/layout/Footer';
import Home from './components/layout/Home';
import Login from './components/auth/Login';
import Register from './components/auth/Register';

class App extends Component {
  render() {
    return (
      <Router>
        <div>
          <Navbar />
          <Route exact path="/" component={Home} />
          <Route exact path="/auth/login" render={(props) => <Login {...props} />} />
          <Route exact path="/auth/register" render={(props) => <Register {...props} />} />
          <Footer />
        </div>
      </Router>
    );
  }
}

export default App;
