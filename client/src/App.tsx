import React, { useState } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Navbar from './components/layout/Navbar';
import Footer from './components/layout/Footer';
import Home from './components/layout/Home';
import Login from './components/auth/Login';
import Logout from './components/auth/Logout';
import Register from './components/auth/Register';
import AccountsIndex from './components/accounts/AccountsIndex';

export default () => {
  // TODO: Validate authentication token
  const [isLoggedIn, setLoggedIn] = useState(localStorage.getItem('authorization') !== null);

  return (
    <Router>
      <div>
        <Navbar isLoggedIn={isLoggedIn} />
        <Route exact path="/" component={Home} />
        <Route exact path="/auth/login" render={(props) => <Login setLoggedIn={setLoggedIn} {...props} />} />
        <Route exact path="/auth/logout" render={(props) => <Logout setLoggedIn={setLoggedIn} {...props} />} />
        <Route exact path="/auth/register" render={(props) => <Register {...props} />} />
        <Route exact path="/accounts" render={(props) => <AccountsIndex {...props} />} />
        <Footer />
      </div>
    </Router>
  );
}
