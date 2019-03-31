import React from 'react';
import {
  Container,
  Row,
  Col,
} from 'reactstrap';
import { Link } from 'react-router-dom';

import AuthForm from './AuthForm';
import { History } from 'history';

interface Props {
  history: History
};

export default ({ history }: Props) => (
  <Container>
    <Row>
      <Col>
        <h1 className="text-center">Login to de-dns</h1>
      </Col>
    </Row>
    <Row className="justify-content-center">
      <Col xs={12} sm={10} md={8} lg={6}>
        <AuthForm endpoint="/login" history={history} />
      </Col>
    </Row>
    <Row className="mt-2">
      <Col className="text-center">
        <Link to="/auth/register" className="text-reset">Don't have an account?</Link>
      </Col>
    </Row>
  </Container>
);
