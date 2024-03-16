import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repositories/presentation/screens/favorites_screen.dart';
import 'package:search_repositories/presentation/provider/provider.dart';
import 'package:search_repositories/presentation/screens/repository_search_screen.dart';
import 'package:search_repositories/presentation/screens/splash_screen.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RepositoryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          "repostory_search_screen": (context) => RepositorySearchScreen(),
          "favorite_screen": (context) => const FavoriteScreen(),
        },
      ),
    );
  }
}
