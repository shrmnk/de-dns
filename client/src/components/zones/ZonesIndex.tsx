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

interface Zone {
  name: string,
  identifier: string
};

const RetrieveZones = ({ history }: Props): JSX.Element => {
  const authorization = localStorage.getItem('authorization');
  if (!authorization) {
    alert('Please sign in first');
    history.push('/auth/login');
    return <pre>Please sign in</pre>;
  }

  const data = useFetch('/api/zones', {
    method: 'GET',
    mode: 'cors',
    cache: 'no-cache',
    headers: {
      'Accept': 'application/json',
      'Authorization': authorization
    }
  });

  if (data.zones) {

    return <>
      {data.zones.map((zone: Zone, index: number) => {
        const { name, identifier } = zone;
        return (
          <tr key={index}>
            <td>{index + 1}</td>
            <td><a href={name}>{name}</a></td>
            <td className="text-monospace">{identifier}</td>
            <td>
              <ButtonGroup>
                <Button size="sm" color="primary" tag={Link} to={`/zones/${name}/hostnames`}>Add Hostname</Button>
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
          <h1 className="text-center">Zones</h1>
        </Col>
      </Row>
      <Row>
        <Table hover>
          <thead>
            <tr>
              <th>No.</th>
              <th>Name</th>
              <th>Identifier</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <Suspense fallback={<tr><td className="text-center" colSpan={4}>Loading...</td></tr>}>
              <RetrieveZones history={history} />
            </Suspense>
          </tbody>
        </Table>
      </Row>
    </Container>
  );
}
