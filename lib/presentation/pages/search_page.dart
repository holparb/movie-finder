import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (text) {},
            decoration: InputDecoration(
              hintText: "Search movies",
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white70,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          )
        ],
      ),
    );
  }
}
