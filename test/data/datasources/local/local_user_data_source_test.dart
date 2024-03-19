import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_finder/core/constants.dart' as constants;


import '../../../helper/test_data.dart';

void main() {

  late LocalUserDataSource userDataSource;

  setUp(() async {
    userDataSource = const LocalUserDataSource();
  });

  group("User data handling", () {
    test("Writing user data", () async {
      // arrange
      SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // act
      await userDataSource.writeUserData(testSessionId, testUserModel);
      // assert
      expect(prefs.getString(constants.sessionId), testSessionId);
      expect(prefs.getString(constants.userId), testUserModel.id.toString());
      expect(prefs.getString(constants.username), testUserModel.username);
    });

    test("Deleting user data", () async {
      // arrange
      SharedPreferences.setMockInitialValues({
        "userId": "123",
        "userName": "user",
        "sessionId": "session12345Id"
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // act
      await userDataSource.deleteUserData();
      // assert
      expect(prefs.getString(constants.sessionId), null);
      expect(prefs.getString(constants.userId), null);
      expect(prefs.getString(constants.username), null);
    });
  });

  group("Read sessionId", () {
    test("Read sessionId when sessionId exists in local storage", () async {
      // arrange
      SharedPreferences.setMockInitialValues({
        "sessionId": testSessionId
      });
      // act
      final sessionId = await userDataSource.readSessionId();
      // assert
      expect(sessionId, testSessionId);
    });

    test("Read sessionId when sessionId does not exist in local storage ", () async {
      // arrange
      SharedPreferences.setMockInitialValues({});
      // act
      final sessionId = await userDataSource.readSessionId();
      // assert
      expect(sessionId, null);
    });

    test("Read sessionId when sessionId exist in local storage but it's empty ", () async {
      // arrange
      SharedPreferences.setMockInitialValues({
        "sessionId": ""
      });
      // act
      final sessionId = await userDataSource.readSessionId();
      // assert
      expect(sessionId, null);
    });
  });

  group("Read userId", () {
    test("Read userId when userId exists in local storage", () async {
      // arrange
      SharedPreferences.setMockInitialValues({
        "userId": testUserModel.id.toString()
      });
      // act
      final userId = await userDataSource.readUserId();
      // assert
      expect(userId, testUserModel.id.toString());
    });

    test("Read userId when userId does not exist in local storage ", () async {
      // arrange
      SharedPreferences.setMockInitialValues({});
      // act
      final userId = await userDataSource.readUserId();
      // assert
      expect(userId, null);
    });

    test("Read userId when userid exist in local storage but it's empty ", () async {
      // arrange
      SharedPreferences.setMockInitialValues({
        "userId": ""
      });
      // act
      final userId = await userDataSource.readUserId();
      // assert
      expect(userId, null);
    });
  });

  group("Read username", () {
    test("Read username when userId username in local storage", () async {
      // arrange
      SharedPreferences.setMockInitialValues({
        "username": testUserModel.username
      });
      // act
      final username = await userDataSource.readUsername();
      // assert
      expect(username, testUserModel.username);
    });

    test("Read username when username does not exist in local storage ", () async {
      // arrange
      SharedPreferences.setMockInitialValues({});
      // act
      final username = await userDataSource.readUsername();
      // assert
      expect(username, null);
    });

    test("Read username when username exist in local storage but it's empty ", () async {
      // arrange
      SharedPreferences.setMockInitialValues({
        "username": ""
      });
      // act
      final username = await userDataSource.readUsername();
      // assert
      expect(username, null);
    });
  });

}