import 'dart:io';

getAuthHeader(String token) {
  return {
    HttpHeaders.authorizationHeader: "JWT $token", 
    HttpHeaders.contentTypeHeader: "application/json", 
    HttpHeaders.acceptEncodingHeader: "application/json"
  };
}

getJsonHeader() {
  return {
    HttpHeaders.contentTypeHeader: "application/json", 
    HttpHeaders.acceptEncodingHeader: "application/json"
  };
}