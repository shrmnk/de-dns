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
const useFetch = require('fetch-suspense');

interface Props {
  history: History,
  id: number
};

interface Zone {
  name: string,
  identifier: string
};

const RetrieveZones = ({ history, id }: Props): JSX.Element => {
  const authorization = localStorage.getItem('authorization');
  if (!authorization) {
    alert('Please sign in first');
    history.push('/auth/login');
    return <pre>Please sign in</pre>;
  }

  const data = useFetch(`/api/cloudflare_accounts/${id}/zones/new`, {
    method: 'GET',
    mode: 'cors',
    cache: 'no-cache',
    headers: {
      'Accept': 'application/json',
      'Authorization': authorization
    }
  });

  const addZone = (identifier: string, name: string): void => {
    fetch(`/api/cloudflare_accounts/${id}/zones`, {
      method: 'POST',
      mode: 'cors',
      cache: 'no-cache',
      body: JSON.stringify({
        zone: {
          identifier,
          name
        }
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': authorization
      }
    })
      .then(res => {
        if (res.status === 200) {
          res.json().then((data) => {
            alert(`Added ${data.zone.name} to your zones`);
            history.push('/zones');
          });

          return;
        }
        res.json().then((data) => {
          alert("Error: " + data.errors.join(', '));
        });
      })
      .catch((err) => {
        console.error(err);
        alert('Error, please try again');
      });
  };

  if (data.cloudflareZones) {
    return <>
      {data.cloudflareZones.map((zone: Zone, index: number) => {
        const { name, identifier } = zone;
        return (
          <tr key={index}>
            <td>{index + 1}</td>
            <td>{name}</td>
            <td>
              <ButtonGroup>
                <Button size="sm" color="primary" onClick={(e: { preventDefault: () => void; }) => { e.preventDefault(); addZone(identifier, name); }}>Add {identifier}</Button>
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

export default ({ history, id }: Props) => {
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
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <Suspense fallback={<tr><td className="text-center" colSpan={4}>Loading...</td></tr>}>
              <RetrieveZones history={history} id={id} />
            </Suspense>
          </tbody>
        </Table>
      </Row>
    </Container>
  );
}
