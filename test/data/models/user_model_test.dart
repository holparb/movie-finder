import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/domain/entities/user.dart';

import '../../fixtures/fixture_reader.dart';
import '../../helper/test_data.dart';

void main() {

  test("Should be a subclass of User entity", () {
    // assert
    expect(testUserModel, isA<User>());
  });

  test("Should return a valid model from a json file and given sessionId", () async {
    // arrange
    final Map<String, dynamic> json = jsonDecode(fixture("user_model.json"));
    // act
    final result = UserModel.fromJson(json, testSessionId);
    // assert
    expect(result, testUserModel);
  });
}