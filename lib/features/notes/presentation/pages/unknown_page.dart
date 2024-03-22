import 'package:flutter/material.dart';
import 'package:not_notes/config/constants/app_constants.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Unknown Page'),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: AppConstants.logoSize,
            color: Theme.of(context).colorScheme.error,
          ),
          Text(
            'Unknown Page',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'This page does not exist.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
