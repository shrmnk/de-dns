import React from 'react';
import {
  Container, Row, Col,
} from 'reactstrap';
import { Link } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEthernet } from '@fortawesome/free-solid-svg-icons';

export default () => {
  return (
    <Container fluid className="text-secondary py-3 bar-top">
      <Row>
        <Col>
          <Container>
            <Row>
              <Col><hr /></Col>
            </Row>
            <Row className="justify-content-between">
              <Col>
                <small>&copy; A <a className="text-dark text-decoration-none" href="https://koaandco.com/">koa &amp; co</a> production</small>
              </Col>
              <Col className="text-center text-info">
                <FontAwesomeIcon icon={faEthernet} size="2x" />
              </Col>
              <Col className="text-right">
                <small>
                  <Link to="/about" className="text-reset">About</Link>
                </small>
              </Col>
            </Row>
          </Container>
        </Col>
      </Row>
    </Container>
  );
};
