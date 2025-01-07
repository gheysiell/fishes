import 'package:fishes/core/navigation_service.dart';
import 'package:fishes/core/providers.dart';
import 'package:fishes/core/theme_provider.dart';
import 'package:fishes/features/fishes/presentation/views/fishes_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const Fishes());
}

class Fishes extends StatelessWidget {
  const Fishes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Fishes',
        theme: buildTheme(),
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        home: const FishesView(),
      ),
    );
  }
}
