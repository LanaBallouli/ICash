import 'package:flutter/material.dart';

class IncrementalButton extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const IncrementalButton({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.remove),
          color: Colors.red,
        ),

        Spacer(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        Spacer(),

        IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.add),
          color: Colors.green,
        ),
      ],
    );
  }
}