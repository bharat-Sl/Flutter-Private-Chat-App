import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/Pages/chatPage.dart';
import 'package:flutterchat/main.dart';
import 'package:regexed_validator/regexed_validator.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(user: user),
      ),
    );
  }

  String emailValidation(String str) {
    if (validator.email(str)) {
      return null;
    } else if (str.length == 0) {
      return 'Email required';
    } else {
      return 'Enter a valid email!';
    }
  }

  String passwordValidation(String str) {
    if (validator.password(str)) {
      return null;
    } else if (str.length == 0) {
      return 'Password required';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Chat',
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset(
                  'assets/LogoChat.png',
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (val) => emailValidation(val),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock_open),
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (val) => passwordValidation(val),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'Login',
            callback: () async {
              if (_formKey.currentState.validate()) {
                await loginUser();
              }
            },
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
