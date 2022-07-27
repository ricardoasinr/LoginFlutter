//import 'package:app_productos/widgets/Auth_background.dart';
import 'package:app_productos/providers/login_from_provider.dart';
import 'package:app_productos/services/auth_services.dart';
import 'package:app_productos/services/notifications.dart';
import 'package:app_productos/ui/input_decoration.dart';
import 'package:app_productos/widgets/card_container.dart';
import 'package:app_productos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../widgets/Auth_background.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 200),
        CardContainer(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('Iniciar sesión',
                style: Theme.of(context).textTheme.headline4),
            SizedBox(
              height: 30,
            ),
            ChangeNotifierProvider(
              create: (_) => LoginFormProvider(),
              child: LoginForm(),
            )
            // LoginForm()
          ],
        )),
        SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Colors.black.withOpacity(0.1)
                    // : MaterialStateProperty.all(StadiumBorder())))
                    ),
          ),
          child: Text(
            'Crear una nueva cuenta',
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ]),
    )));
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: "example@email.com",
                labelText: "Email",
                prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value) => loginForm.email = value,
            validator: ((value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Introduce un email válido';
            }),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: "********",
                labelText: "Contraseña",
                prefixIcon: Icons.lock_outline_sharp),
            onChanged: (value) => loginForm.password = value,
            validator: ((value) {
              if (value != null && value.length >= 6) {
                return null;
              }
              return 'La contraseña debe ser mayor a 6 caracteres';
            }),
          ),
          SizedBox(
            height: 25,
          ),
          MaterialButton(
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    if (loginForm.isValidForm()) {
                      FocusScope.of(context).unfocus();
                      loginForm.isLoading = true;
                      //await Future.delayed(Duration(seconds: 3));

                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      final String? error = await authService.loginUser(
                          loginForm.email, loginForm.password);

                      if (error == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        print(error);
                        NotificationsService.showSnackBar(error);
                        loginForm.isLoading = false;
                      }
                    } else {
                      return null;
                    }
                  },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepOrange,
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: Text(
              loginForm.isLoading ? 'Espere' : "Ingresar",
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
