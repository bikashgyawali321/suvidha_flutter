import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: Text('orders'),
        )
      ],
    );
  }
}
