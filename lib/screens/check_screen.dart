import 'package:app_productos/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Text("Cargando datos...");

            Future.microtask(() {
              Navigator.of(context).restorablePushReplacementNamed('home');
            });
            return Container();
          },
        ),
      ),
    );
  }
}
