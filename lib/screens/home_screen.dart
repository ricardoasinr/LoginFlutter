import 'package:app_productos/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                authService.logOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(child: Text('Home Screen')),
    );
  }
}
