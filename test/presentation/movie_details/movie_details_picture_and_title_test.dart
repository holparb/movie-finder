import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_picture_and_title.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_subtext.dart';

import '../../helper/test_data.dart';
import '../../helper/test_widget_creator.dart';

void main() {
  testWidgets("should render outer AspectRatio Widget with correct aspect ratio ", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsPictureAndTitle(movie: testMovieDetail)));

    AspectRatio aspectRatio = widgetTester.firstWidget(find.byType(AspectRatio));
    expect(aspectRatio, isNotNull);
    expect(aspectRatio.aspectRatio, equals(1));
  });

  testWidgets("should render all the major widgets besides AspectRatio", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsPictureAndTitle(movie: testMovieDetail)));

    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Positioned), findsNWidgets(2));
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.text(testMovieDetail.title), findsOneWidget);
    expect(find.byType(MovieDetailsSubtext), findsOneWidget);
  });
}