import 'dart:developer';

import 'package:flutter/material.dart';

class ReflectionResponsePage extends StatelessWidget {
  const ReflectionResponsePage({
    super.key,
    required this.response,
  });

  final String response;

  @override
  Widget build(BuildContext context) {
    log(response);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Reflection Result',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Text(response),
        ),
      ),
    );
  }
}
