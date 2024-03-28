import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helper/test_data.dart';
import 'data_source_test.mocks.dart';

void main() {

  late MockClient mockClient;
  late AuthDataSource authDataSource;

  setUp(() {
    mockClient = MockClient();
    authDataSource = AuthDataSource(mockClient);
  });

  String createUrlString(String endpoint) {
    return "${TmdbApiConfig.baseUrl}$endpoint?api_key=${TmdbApiConfig.apiKey}";
  }
  
  const Map<String, String> loginRequestBody = {
    "username": "user",
    "password": "password"
  };

  group("Get request token", () {
    test("Request token is successfully returned", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.getRequestTokenEndpoint))))
          .thenAnswer((_) async => http.Response(fixture("request_token_model.json"), 200));
      // act
      final result = await authDataSource.getRequestToken();
      // assert
      expect(result, testRequestTokenModel);
    });

    test("Should throw exception if response code is not 200", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.getRequestTokenEndpoint))))
          .thenAnswer((_) async => http.Response("Not authorized!", 400));
      // act
      final call = authDataSource.getRequestToken();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.getRequestTokenEndpoint)))).thenThrow(Exception("error message"));
      // act
      final call = authDataSource.getRequestToken();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
  });
  
  group("Validate request token", () {
    test("Should return a validated request token", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(createUrlString(TmdbApiConfig.authenticationEndpoint)),
          body: jsonEncode(loginRequestBody),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response(fixture("request_token_model.json"), 200));
      // act
      final result = await authDataSource.validateToken(loginRequestBody);
      // assert
      expect(result, testRequestTokenModel);
    });

    test("Should catch exception if status code is not 200", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(createUrlString(TmdbApiConfig.authenticationEndpoint)),
          body: jsonEncode(loginRequestBody),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response("Not authorized!", 400));
      // act
      final call = authDataSource.validateToken(loginRequestBody);
      // assert
      expect(() => call, throwsA(isA<HttpError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(createUrlString(TmdbApiConfig.authenticationEndpoint)),
          body: jsonEncode(loginRequestBody),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenThrow(Exception("error message"));
      // act
      final call = authDataSource.validateToken(loginRequestBody);
      // assert
      expect(() => call, throwsA(isA<HttpError>()));
    });
  });

  group("Get session id", () {
    test("Should return a session id", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(createUrlString(TmdbApiConfig.createSessionEndpoint)),
          body: jsonEncode(testRequestTokenModel.toJson()),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response(fixture("session_response.json"), 200));
      // act
      final result = await authDataSource.createSession(testRequestTokenModel);
      // assert
      expect(result, testSessionId);
    });

    test("Should catch exception if status code is not 200", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(createUrlString(TmdbApiConfig.createSessionEndpoint)),
          body: jsonEncode(testRequestTokenModel.toJson()),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response("Bad request!", 400));
      // act
      final call = authDataSource.createSession(testRequestTokenModel);
      // assert
      expect(() => call, throwsA(isA<HttpError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(createUrlString(TmdbApiConfig.createSessionEndpoint)),
          body: jsonEncode(testRequestTokenModel.toJson()),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenThrow(Exception("error message"));
      // act
      final call = authDataSource.createSession(testRequestTokenModel);
      // assert
      expect(() => call, throwsA(isA<HttpError>()));
      });
    });

  group("Get user account details", () {
    test("Should return a valid user account details", () async {
      // arrange
      when(mockClient.get(Uri.parse("${createUrlString("/account")}&session_id=$testSessionId")))
          .thenAnswer((_) async => http.Response(fixture("user_model.json"), 200));
      // act
      final result = await authDataSource.getUserAccountDetails(testSessionId);
      // assert
      expect(result.sessionId, testSessionId);
      expect(result.username, testUserModel.username);
      expect(result.id, testUserModel.id);
    });

    test("Should catch exception if status code is not 200", () async {
      // arrange
      when(mockClient.get(Uri.parse("${createUrlString("/account")}&session_id=$testSessionId")))
          .thenAnswer((_) async => http.Response("Something went wrong!", 404));
      // act
      final call = authDataSource.getUserAccountDetails(testSessionId);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.get(Uri.parse("${createUrlString("/account")}&session_id=$testSessionId"))).thenThrow(Exception("error message"));
      // act
      final call = authDataSource.getUserAccountDetails(testSessionId);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
  });

  group("Delete session", () {
    test("Should successfully delete session", () async {
      final sessionIdBody = {
        "session_id": testSessionId
      };
      // arrange
      when(mockClient.delete(
          Uri.parse(createUrlString(TmdbApiConfig.deleteSession)),
          body: jsonEncode(sessionIdBody),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response('{"success": true}', 200));
      // act
      final result = await authDataSource.deleteSession(sessionIdBody);
      // assert
      expect(result, true);
    });

    test("Should return false in case if delete was unsuccessful", () async {
      final sessionIdBody = {
        "session_id": testSessionId
      };
      // arrange
      when(mockClient.delete(
          Uri.parse(createUrlString(TmdbApiConfig.deleteSession)),
          body: jsonEncode(sessionIdBody),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response('{"success": false}', 200));
      // act
      final result = await authDataSource.deleteSession(sessionIdBody);
      // assert
      expect(result, false);
    });

    test("Should throw exception if an error code other than 200 was returned", () async {
      final sessionIdBody = {
        "session_id": testSessionId
      };
      // arrange
      when(mockClient.delete(
          Uri.parse(createUrlString(TmdbApiConfig.deleteSession)),
          body: jsonEncode(sessionIdBody),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response("Something went wrong!", 404));
      // act
      final call = authDataSource.deleteSession(sessionIdBody);
      // assert
      expect(() => call, throwsA(isA<HttpError>()));
    });

    test("Should catch exception in case if an exception was thrown during delete", () async {
      final sessionIdBody = {
        "session_id": testSessionId
      };
      // arrange
      when(mockClient.delete(
          Uri.parse(createUrlString(TmdbApiConfig.deleteSession)),
          body: jsonEncode(sessionIdBody),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenThrow(Exception("exception!"));
      // act
      final call = authDataSource.deleteSession(sessionIdBody);
      // assert
      expect(() => call, throwsA(isA<HttpError>()));
    });
  });
}