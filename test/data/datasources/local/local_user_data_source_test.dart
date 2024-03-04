import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/test_data.dart';

void main() {

  late LocalUserDataSource userDataSource;

  setUp(() async {
    userDataSource = const LocalUserDataSource();
  });

  test("Writing user data", () async {
    // arrange
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // act
    await userDataSource.writeUserData(testSessionId, testUserModel);
    // assert
    expect(prefs.getString("sessionId"), testSessionId);
    expect(prefs.getInt("userId"), testUserModel.id);
    expect(prefs.getString("userName"), testUserModel.username);
  });

  test("Deleting user data", () async {
    // arrange
    SharedPreferences.setMockInitialValues({
      "userId": 123,
      "userName": "user",
      "sessionId": "session12345Id"
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // act
    await userDataSource.deleteUserData();
    // assert
    expect(prefs.getString("sessionId"), null);
    expect(prefs.getInt("userId"), null);
    expect(prefs.getString("userName"), null);
  });

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
}