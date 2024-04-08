import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/watchlist_bloc.dart';
import 'package:movie_finder/presentation/pages/home_page.dart';
import 'package:movie_finder/presentation/pages/saved_movies_page.dart';
import 'package:movie_finder/presentation/pages/search_page.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).colorScheme.background;
    return Scaffold(
      appBar: AppBar(
        title: const Text("MovieFinder", style: TextStyle(
          fontFamily: "BebasNeue",
          color: Colors.red,
          fontSize: 52,
        )),
        centerTitle: true,
      ),
      body:  BlocListener<AuthBloc, AuthState>(
        listenWhen: (previousState, currentState) {
          return (previousState is LoggingIn && currentState is LoggedIn) ||
              (previousState is NotLoggedIn && currentState is LoggedIn);
        },
        listener: (context, state) {
          if (state is LoggedIn) {
            BlocProvider.of<WatchlistBloc>(context).add(const GetWatchlist());
          }
        },
        child: IndexedStack(
          index: currentPageIndex,
          children: const <Widget>[
            SearchPage(),
            HomePage(),
            SavedMoviesPage()
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) => states.contains(MaterialState.selected)
                ? const TextStyle(fontFamily: "AbeeZee", color: Colors.black)
                : const TextStyle(fontFamily: "AbeeZee", color: Colors.grey),
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          destinations: <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.search, color: iconColor,),
              icon: Icon(Icons.search_outlined, color: iconColor,),
              label: "Search",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: iconColor,),
              icon: Icon(Icons.home_outlined, color: iconColor,),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.movie, color: iconColor,),
              icon: Icon(Icons.movie_outlined, color: iconColor,),
              label: "Watchlist",
            ),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: Colors.white,
          indicatorColor: Theme.of(context).colorScheme.outline,
          surfaceTintColor: Colors.black12,
        ),
      ),
    );
  }
}
