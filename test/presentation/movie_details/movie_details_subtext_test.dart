import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_subtext.dart';

import '../../helper/test_data.dart';
import '../../helper/test_widget_creator.dart';

void main() {
  testWidgets("should render Padding first with correct top value", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsSubtext(movie: testMovieDetail)));

    Padding padding = widgetTester.firstWidget(find.byType(Padding));
    expect(padding, isNotNull);
    expect(padding.padding, const EdgeInsets.only(top:8.0));
  });

  testWidgets("should render all other widgets besides Padding", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsSubtext(movie: testMovieDetail)));

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
  });

  testWidgets("text fields should have correct value based on provided Movie entity", (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest(MovieDetailsSubtext(movie: testMovieDetail)));

    Text subText = find.byType(Text).evaluate().elementAt(0).widget as Text;
    expect(subText, isNotNull);
    expect(subText.data, "1997 • genreName • 2h 37m");

    Text ratingText = find.byType(Text).evaluate().elementAt(1).widget as Text;
    expect(ratingText, isNotNull);
    expect(ratingText.data, "5.6/10");
  });
}