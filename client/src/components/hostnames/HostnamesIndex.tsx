import React, { Suspense, useState } from 'react';
import {
  Container,
  Row,
  Col,
  Table,
  Button,
  ButtonGroup,
} from 'reactstrap';
import { History } from 'history';
import { Link } from 'react-router-dom';
const useFetch = require('fetch-suspense');

interface Props {
  history: History
};

interface Hostname {
  name: string,
  token: string,
  a?: string,
  aaaa?: string,
  mx?: string
};

const RetrieveHostnames = ({ history }: Props): JSX.Element => {
  const authorization = localStorage.getItem('authorization');
  if (!authorization) {
    alert('Please sign in first');
    history.push('/auth/login');
    return <pre>Please sign in</pre>;
  }

  const data = useFetch('/api/hostnames', {
    method: 'GET',
    mode: 'cors',
    cache: 'no-cache',
    headers: {
      'Accept': 'application/json',
      'Authorization': authorization
    }
  });

  if (data.hostnames) {
    return <>
      {data.hostnames.map((hostname: Hostname, index: number) => {
        const { name, token } = hostname;
        const [revealed, setIsRevealed] = useState(false);

        return (
          <tr key={index}>
            <td>{index + 1}</td>
            <td><a href={name}>{name}</a></td>
            <td className="text-monospace">
              {!revealed && <Button block size="sm" color="secondary" onClick={() => setIsRevealed(!revealed)}>Reveal</Button>}
              {revealed && token}
            </td>
            <td>
              <ButtonGroup>
                <Button size="sm" disabled>Edit (WIP)</Button>
                <Button size="sm" disabled>Refresh Token</Button>
              </ButtonGroup>
            </td>
          </tr>
        );
      })}
    </>;
  } else {
    return <pre>Error retrieving data: {data.errors.join(', ')}</pre>
  }
}

export default ({ history }: Props) => {
  return (
    <Container>
      <Row>
        <Col>
          <h1 className="text-center">Hostnames</h1>
        </Col>
      </Row>
      <Row>
        <Table hover>
          <thead>
            <tr>
              <th>No.</th>
              <th>Name</th>
              <th>Token</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <Suspense fallback={<tr><td className="text-center" colSpan={4}>Loading...</td></tr>}>
              <RetrieveHostnames history={history} />
            </Suspense>
          </tbody>
        </Table>
      </Row>
    </Container>
  );
}
