import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/Pages/chatPage.dart';
import 'package:flutterchat/main.dart';
import 'package:regexed_validator/regexed_validator.dart';

class Registration extends StatefulWidget {
  static const String id = 'Registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;
  String repassword;
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
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
    } else {
      return 'Enter a valid email!';
    }
  }

  String passwordValidation(String str) {
    if (validator.password(str)) {
      return null;
    } else if (str.length == 0) {
      return 'Password required';
    } else {
      return 'Too weak';
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
                  SizedBox(height: 5.0),
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
                  SizedBox(height: 5.0),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      labelText: 'Confirm Password',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val == password ? null : 'Re-enter the password',
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => repassword = val);
                    },
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'Register',
            callback: () async {
              if (_formKey.currentState.validate()) {
                return registerUser();
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
