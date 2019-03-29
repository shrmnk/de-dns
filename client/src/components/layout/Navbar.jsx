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
import { faBolt, faEthernet, faCloud, faRulerHorizontal, faUserAlt } from '@fortawesome/free-solid-svg-icons';

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
        <Collapse isOpen={toggle} navbar className="w-100">
          <Nav navbar className="justify-content-around w-100">

            <NavItem>
              <NavLink tag={Link} to="/hostnames" className="text-light">
                <FontAwesomeIcon icon={faBolt} className="mr-1" />
                hostnames
              </NavLink>
            </NavItem>

            <NavItem>
              <NavLink tag={Link} to="/zones" className="text-light">
                <FontAwesomeIcon icon={faRulerHorizontal} className="mr-1" />
                zones
              </NavLink>
            </NavItem>

            <NavItem>
              <NavLink tag={Link} to="/accounts" className="text-light">
                <FontAwesomeIcon icon={faCloud} className="mr-1" />
                accounts
              </NavLink>
            </NavItem>

            <NavItem>
              <NavLink tag={Link} to="/auth/login" className="text-light">
                <FontAwesomeIcon icon={faUserAlt} className="mr-1" />
                login
              </NavLink>
            </NavItem>
          </Nav>
        </Collapse>
      </Navbar>
    </div>
  );
}
