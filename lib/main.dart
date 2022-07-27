import 'package:app_productos/screens/check_screen.dart';
import 'package:app_productos/screens/register_screen.dart';
import 'package:app_productos/screens/screens.dart';
import 'package:app_productos/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'checkIn',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
        'register': (_) => RegisterScreen(),
        'checkIn': (_) => CheckAuthScreen()
      },
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
    );
  }
}
