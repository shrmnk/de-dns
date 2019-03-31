import React, { useState, FormEvent } from 'react';
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
import { History } from 'history';

interface Props {
  endpoint: string,
  history: History
}

export default ({ endpoint, history }: Props) => {

  const [password, setPassword] = useState('');
  const [email, setEmail] = useState('');

  const submitForm = (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    fetch(endpoint, {
      method: 'POST',
      mode: 'cors',
      cache: 'no-cache',
      body: JSON.stringify({
        user: {
          password,
          email
        }
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
      .then(res => {
        if (res.status === 200) {
          // JWT token is in authorization header
          const authorization = res.headers.get('authorization');

          if (authorization) {
            localStorage.setItem('authorization', authorization);
            history.push('/');
          } else {
            alert('Please sign in!');
            history.push('/auth/login');
          }
        } else if(res.status == 400) {
          // Registration probably failed
          res.json().then((data) => {
            alert("Error: " + JSON.stringify(data));
          });
        } else if (res.status === 401) {
          // Failed to login
          // Obtain error from json.error
          res.json().then((data) => {
            alert("Error: " + data.error);
          });
        }
      })
      .catch((err) => {
        console.error(err);
        alert('Error, please try again');
      });
  };

  return (
    <Card>
      <CardBody>
        <Form onSubmit={(e: FormEvent<HTMLFormElement>) => submitForm(e)}>
          <FormGroup row>
            <Label for="email" xs={12} sm={3}>Email</Label>
            <Col sm={9}>
              <Input type="email" name="email" id="email" value={email} onChange={(e: { target: { value: React.SetStateAction<string>; }; }) => setEmail(e.target.value)} />
            </Col>
          </FormGroup>
          <FormGroup row>
            <Label for="password" xs={12} sm={3}>Password</Label>
            <Col sm={9}>
              <Input type="password" name="password" id="password" value={password} onChange={(e: { target: { value: React.SetStateAction<string>; }; }) => setPassword(e.target.value)} />
            </Col>
          </FormGroup>
          <FormGroup row className="mb-0">
            <Col xs={12}>
              <Button block type="submit">{endpoint.substring(1, 2).toUpperCase()}{endpoint.substring(2)}</Button>
            </Col>
          </FormGroup>
        </Form>
      </CardBody>
    </Card>
  );
};
