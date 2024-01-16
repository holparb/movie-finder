import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_body.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_picture_and_title.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_subtext.dart';

import '../../helper/test_data.dart';
import '../../helper/test_widget_creator.dart';

void main() {
  testWidgets("Scaffold should render correctly", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsBody(movie: testMovieDetail)));

    Scaffold scaffold = widgetTester.firstWidget(find.byType(Scaffold));
    expect(scaffold, isNotNull);
    expect(scaffold.body, isA<SingleChildScrollView>());
  });

  testWidgets("MovieDetailPictureAndTitle and MovieDetailsSubtext should render", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsBody(movie: testMovieDetail)));

    expect(find.byType(MovieDetailsPictureAndTitle), findsOneWidget);
    expect(find.byType(MovieDetailsSubtext), findsOneWidget);
  });

  testWidgets("overview text should render", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsBody(movie: testMovieDetail)));

    expect(find.text(testMovieDetail.overview), findsOneWidget);
  });
}