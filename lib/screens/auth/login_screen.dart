import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:workies/screens/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type something';
                }

                return null;
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return 'Your password needs to be atleast 6 characters';
                }

                return null;
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: register,
              child: Text("Sign In"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      formState.save();

      try {
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);

        FirebaseUser user = result.user;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(),
          ),
        );
      } catch (error) {
        print(error.code);
      }
    }
  }
}
