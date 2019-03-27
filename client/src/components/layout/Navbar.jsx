import React, { useState } from 'react';
import {
  Navbar,
  Nav,
  NavItem,
  NavLink,
  NavbarBrand,
  NavbarToggler,
  Collapse,
} from 'reactstrap';
import { Link } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBolt, faEthernet, faCloud } from '@fortawesome/free-solid-svg-icons';

export default () => {
  const [toggle, setToggle] = useState(false);

  return (
    <div>
      <Navbar color="dark" expand="md" className="border-bottom" fixed="top">
        <NavbarBrand href="/" className="text-reset">
          <span className="text-light">
            <FontAwesomeIcon icon={faEthernet} className="mr-2" />
            de-dns
          </span>
        </NavbarBrand>
        <NavbarToggler onClick={() => setToggle(!toggle)} />
        <Collapse isOpen={toggle} navbar className="justify-content-between">
          <Nav navbar>
            <NavItem>
              <NavLink tag={Link} to="/zones" className="text-light">
                Zones
              </NavLink>
            </NavItem>
          </Nav>
          <Nav navbar>
            <NavItem>
              <NavLink tag={Link} to="/accounts" className="text-light">
                <FontAwesomeIcon icon={faCloud} />
              </NavLink>
            </NavItem>
            <NavItem>
              <NavLink tag={Link} to="/hostnames" className="text-light">
                <FontAwesomeIcon icon={faBolt} />
              </NavLink>
            </NavItem>
          </Nav>
        </Collapse>
      </Navbar>
    </div>
  );
}
