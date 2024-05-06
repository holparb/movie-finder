import 'package:flutter/material.dart';

class ListError extends StatelessWidget {
  const ListError({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.error_outline),
          Text(text, textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
