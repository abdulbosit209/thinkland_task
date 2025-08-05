import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:thinkland_task/config/locator_config.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '404 not found',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Opps something went wrong',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () => locator<RouterService>().replaceAll([Path(name: '/')]),
                child: Text('Go to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
