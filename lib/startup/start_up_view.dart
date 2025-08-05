import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:thinkland_task/config/locator_config.dart';
import 'package:thinkland_task/startup/startup_view_model.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  late final StartupViewModel _viewModel = StartupViewModel();
  late final BestRouterConfig _routerConfig;

  @override
  void initState() {
    super.initState();
    _viewModel.initializeApp();
    _routerConfig = BestRouterConfig(routerService: locator<RouterService>());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppState>(
      valueListenable: _viewModel.appStateNotifier,
      builder: (context, state, _) {
        return MaterialApp.router(
          routerConfig: _routerConfig,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return switch (state) {
              InitializingApp() => _SplashView(),
              AppInitialized() =>  child!,
              AppInitializationError() => _StartupErrorView(
                onRetry: _viewModel.retryInitialization,
              ),
            };
          },
        );
      },
    );
  }
}


class _StartupErrorView extends StatelessWidget {
  const _StartupErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red, 
                size: 48,
              ),
              const SizedBox(height: 16.0), 
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0), 
              const Text(
                'We encountered an error while starting the app.',
                style: TextStyle(fontSize: 16), 
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}