import React from 'react';
import {
  Form,
  FormGroup,
  Label,
  Col,
  Input,
  Button,
  Card,
  CardBody
} from 'reactstrap';

export default ({ hasConfirm = false }) => {

  return (
    <Card>
      <CardBody>
        <Form>
          <FormGroup row>
            <Label for="email" xs={12} sm={3}>Email</Label>
            <Col sm={9}>
              <Input type="email" name="email" id="email" />
            </Col>
          </FormGroup>
          <FormGroup row>
            <Label for="password" xs={12} sm={3}>Password</Label>
            <Col sm={9}>
              <Input type="password" name="password" id="password" />
            </Col>
          </FormGroup>
          {hasConfirm &&
            <FormGroup row>
              <Label for="confirm" xs={12} sm={3}>Confirm Password</Label>
              <Col sm={9}>
                <Input type="password" name="confirm" id="confirm" />
              </Col>
            </FormGroup>
          }
          <FormGroup row className="mb-0">
            <Col xs={12}>
              <Button block>Login</Button>
            </Col>
          </FormGroup>
        </Form>
      </CardBody>
    </Card>
  );
};
