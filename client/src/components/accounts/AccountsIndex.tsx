import React, { Suspense } from 'react';
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
  name?: string,
  email: string,
  id: number
};

const RetrieveAccounts = ({ history }: Props): JSX.Element => {
  const authorization = localStorage.getItem('authorization');
  if (!authorization) {
    alert('Please sign in first');
    history.push('/auth/login');
    return <pre>Please sign in</pre>;
  }

  const data = useFetch('/api/cloudflare_accounts', {
    method: 'GET',
    mode: 'cors',
    cache: 'no-cache',
    headers: {
      'Accept': 'application/json',
      'Authorization': authorization
    }
  });

  if (data.cloudflareAccounts) {

    return <>
      {data.cloudflareAccounts.map((hostname: Hostname, index: number) => {
        const { name, email, id } = hostname;
        return (
          <tr key={index}>
            <td>{index + 1}</td>
            <td>{name || <i>N/A</i>}</td>
            <td>{email}</td>
            <td>
              <ButtonGroup>
                <Button size="sm" color="primary" tag={Link} to={`/accounts/${id}/zones`}>Add Zone</Button>
                <Button size="sm" disabled>Edit (WIP)</Button>
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
          <h1 className="text-center">Accounts</h1>
        </Col>
      </Row>
      <Row>
        <Table hover>
          <thead>
            <tr>
              <th>No.</th>
              <th>Name</th>
              <th>Email</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <Suspense fallback={<tr><td className="text-center" colSpan={4}>Loading...</td></tr>}>
              <RetrieveAccounts history={history} />
            </Suspense>
          </tbody>
        </Table>
      </Row>
    </Container>
  );
}
