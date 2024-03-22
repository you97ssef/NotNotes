import 'package:flutter/material.dart';
import 'package:not_notes/config/constants/app_constants.dart';
import 'package:not_notes/config/widgets/app_widgets.dart';

class ReloadWidget extends StatelessWidget {
  final double? size;
  final Function reloadFunction;

  const ReloadWidget({super.key, required this.reloadFunction, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: size ?? AppConstants.logoSize,
            color: Theme.of(context).colorScheme.error,
          ),
          Text(
            'Reload',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'An error occurred. Please reload.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          AppWidgets.mediumGap,
          FilledButton.tonalIcon(
            onPressed: () => reloadFunction(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reload'),
          ),
        ],
      ),
    );
  }
}
