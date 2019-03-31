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

  localStorage.removeItem('authorization');
  history.push('/');
  alert('You have been logged out. Please sign in again.');
  setLoggedIn(false);

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
