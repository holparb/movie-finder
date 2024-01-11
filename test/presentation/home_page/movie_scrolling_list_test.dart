import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

import '../../helper/test_data.dart';
import '../../helper/test_widget_creator.dart';

void main() {

  testWidgets("render outer container and check it has correct size", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(const MovieScrollingList(movies: testMovies)));

    SizedBox container = widgetTester.firstWidget(find.byType(SizedBox));
    expect(container, isNotNull);
    expect(container.height, equals(200.0));
  });

  testWidgets("render listview container and check item count", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(const MovieScrollingList(movies: testMovies)));

    ListView listView = widgetTester.firstWidget(find.byType(ListView));
    expect(listView, isNotNull);

    // TODO check listView item count if possible
  });
}