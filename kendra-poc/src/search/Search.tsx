import React from "react";
import awsmobile from '../aws-exports';
import Kendra from 'aws-sdk/clients/kendra';
import S3 from 'aws-sdk/clients/s3';
import {Auth} from 'aws-amplify';

import { QueryResultType } from "./constants";
import { isNullOrUndefined } from "./utils";
import { Spinner } from "react-bootstrap";
import {
  QueryResult,
  QueryResultItem,
  QueryResultItemList
} from "./kendraTypes";

import SearchBar from "./searchBar/SearchBar";
import ResultPanel from "./resultsPanel/ResultPanel";
import Pagination from "./pagination/Pagination";

import "bootstrap/dist/css/bootstrap.min.css";
import "./search.scss";

interface SearchProps {}

interface SearchState {
  dataReady: boolean;
  searchResults: QueryResult;
  topResults: QueryResultItemList;
  faqResults: QueryResultItemList;
  docResults: QueryResultItemList;
  currentPageNumber: number;
  queryText: string;
}

export default class Search extends React.Component<SearchProps, SearchState> {
  constructor(props: SearchProps) {
    super(props);

    this.state = {
      dataReady: false,
      searchResults: {},
      topResults: [],
      faqResults: [],
      docResults: [],
      currentPageNumber: 1,
      queryText: ""
    };
  }

  getResults = (queryText: string, pageNumber: number = 1) => {
    this.setState({ dataReady: false });

    Auth.currentCredentials().then(credentials => {
      const kendra = new Kendra({
        apiVersion: '2019-02-03',
        region: awsmobile.aws_cognito_region,
        credentials: Auth.essentialCredentials(credentials)
      });
      //S3 is needed to get signed urls
      const s3 = new S3({
        apiVersion: '2019-02-03',
        region: awsmobile.aws_cognito_region,
        credentials: Auth.essentialCredentials(credentials)
      });
      Auth.currentAuthenticatedUser().then( usr => {
        const groups = usr.signInUserSession.accessToken.payload['cognito:groups'];
        console.log('Current User:', usr);
        console.log('Groups:', groups);
        const attFilter = {
          "EqualsTo": {
            "Key": "_group_ids",
            "Value": {
              "StringListValue": groups
            }
          }
        }
        console.log('AttributeFilter:', attFilter)
        kendra.query({ 
            IndexId: '10c7ac35-6c65-48f0-9c03-5bfcf58d288d', 
            QueryText: queryText, 
            AttributeFilter: attFilter,
            PageNumber: pageNumber
          }, (err: Error, results: any) => {
        
          if (err) console.log(err, err.stack);
          
          var tempTopResults: QueryResultItemList = [];
          const tempFAQResults: QueryResultItemList = [];
          const tempDocumentResults: QueryResultItemList = [];
          if (results && results.ResultItems) {
            results.ResultItems.forEach((result: QueryResultItem) => {
              if (result.DocumentURI) {
                var res = result.DocumentURI.split('/');
                if (res[2].startsWith("s3")) {
                  //The URI points to an object in an S3 bucket
                  //Get presigned url from s3
                  var bucket = res[3];
                  var key=res[4];
                  for (var i = 5; i < res.length; i++) {
                    key = key + '/' + res[i];
                  }
                  var params = {"Bucket": bucket, "Key": key};
                  var url = s3.getSignedUrl('getObject', params);
                  result.DocumentURI = url;
                }
              }
              switch (result.Type) {
                case QueryResultType.Answer:
                  tempTopResults.push(result);
                  break;
                case QueryResultType.QuestionAnswer:
                  tempFAQResults.push(result);
                  break;
                case QueryResultType.Document:
                  tempDocumentResults.push(result);
                  break;
                default:
                  break;
              }
            });
            this.setState({
              searchResults: results,
              topResults: tempTopResults,
              faqResults: tempFAQResults,
              docResults: tempDocumentResults,
              dataReady: true
            });
          } else {
            this.setState({
              searchResults: {},
              topResults: tempTopResults,
              faqResults: tempFAQResults,
              docResults: tempDocumentResults,
              dataReady: true
            });
          }
          this.setState({
            currentPageNumber: pageNumber,
            queryText: queryText
          });
        });
      });
    });
  };

  render() {
    return (
      <div>
        <SearchBar onSubmit={this.getResults} />
        {this.state.queryText &&
          this.state.dataReady &&
          !isNullOrUndefined(this.state.searchResults) && (
            <div>
              <ResultPanel
                results={this.state.searchResults}
                topResults={this.state.topResults}
                faqResults={this.state.faqResults}
                docResults={this.state.docResults}
                dataReady={this.state.dataReady}
                currentPageNumber={this.state.currentPageNumber}
              />
              <Pagination
                queryText={this.state.queryText}
                currentPageNumber={this.state.currentPageNumber}
                onSubmit={this.getResults}
                results={this.state.searchResults}
              />
            </div>
          )}

        {this.state.queryText && !this.state.dataReady && (
          <div className="results-section center-align">
            <Spinner animation="border" variant="secondary" />
          </div>
        )}
        {this.state.dataReady &&
          this.state.searchResults.TotalNumberOfResults === 0 && (
            <div className="results-section empty-results">
              Kendra didn't match any results to your query.
            </div>
          )}
      </div>
    );
  }
}