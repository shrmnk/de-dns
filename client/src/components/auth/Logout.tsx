import React from 'react';
import {
  Container,
  Row,
  Col,
} from 'reactstrap';
import { History } from 'history';

interface Props {
  history: History,
  setLoggedIn: (arg0: boolean) => void
};

export default ({ history, setLoggedIn }: Props) => {

  const authorization = localStorage.getItem('authorization');
  if (authorization) {
    fetch('/logout', {
      method: 'DELETE',
      mode: 'cors',
      cache: 'no-cache',
      headers: {
        'Accept': 'application/json',
        'Authorization': authorization || ''
      }
    })
      .then(res => {
        if (res.status === 204) {
          localStorage.removeItem('authorization');
          alert('You have been logged out. Please sign in again.');
          setLoggedIn(false);
        } else {
          alert('Error logging out');
        }
        history.push('/');
      })
      .catch((err) => {
        console.error(err);
        alert('Error, please try again');
      });
  }

  return (
    <Container>
      <Row>
        <Col>
          <h1 className="text-center">Logging out...</h1>
        </Col>
      </Row>
    </Container>
  );
}
