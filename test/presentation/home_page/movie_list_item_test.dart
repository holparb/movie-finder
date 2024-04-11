import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_item.dart';

import '../../helper/test_data.dart';
import '../../helper/test_widget_creator.dart';

void main() {
  testWidgets("renders the outer container widget with correct size", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(const MovieListItem(movie: testMovieWithNoDetailsInfo)));

    SizedBox container = widgetTester.firstWidget(find.byType(SizedBox));
    expect(container, isNotNull);
    expect(container.width, equals(150.0));
    expect(container.height, equals(180.0));
  });

  testWidgets("renders all necessary widgets inside outer container", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(const MovieListItem(movie: testMovieWithNoDetailsInfo)));

    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}