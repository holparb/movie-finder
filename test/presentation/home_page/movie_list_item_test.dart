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
    expect(container.width, equals(300.0));
  });

  testWidgets("renders all necessary widgets inside outer container", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(const MovieListItem(movie: testMovieWithNoDetailsInfo)));

    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Positioned), findsNWidgets(3));
    expect(find.byType(Text), findsNWidgets(2));
  });

  testWidgets("renders text widgets with correct text", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(const MovieListItem(movie: testMovieWithNoDetailsInfo)));

    Text titleText = find.byType(Text).evaluate().elementAt(0).widget as Text;
    expect(titleText, isNotNull);
    expect(titleText.data, testMovieWithNoDetailsInfo.title);

    Text genreText = find.byType(Text).evaluate().elementAt(1).widget as Text;
    expect(genreText, isNotNull);
    expect(genreText.data, "Genre, Genre"); // TODO update test when genre eval is done
  });
}