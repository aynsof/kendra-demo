// src/App.js

import React, { Component } from 'react';
import { Header } from 'semantic-ui-react';

import Amplify from 'aws-amplify';
import aws_exports from './aws-exports';
import { withAuthenticator } from 'aws-amplify-react';


import Search from './search/Search.tsx';
import {
  Image
} from "react-bootstrap";
import amazonkendralogo from "./amazon-kendra.jpg";

Amplify.configure(aws_exports);

function App() {
  return (
    <div>
      <div style={{textAlign: 'center'}}>
          <Image src={amazonkendralogo} rounded />
          <p>Amazon Kendra Demo</p>
      </div>
      <Search/>
    </div>
  );
}

export default withAuthenticator(App, {includeGreetings: true});