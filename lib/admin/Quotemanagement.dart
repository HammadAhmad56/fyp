// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Quotemanagement extends StatefulWidget {
  const Quotemanagement({super.key});

  @override
  State<Quotemanagement> createState() => _QuotemanagementState();
}

class _QuotemanagementState extends State<Quotemanagement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Quotemanagement screen'),
      ),
    );
  }
}
