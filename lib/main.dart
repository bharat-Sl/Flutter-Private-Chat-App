import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/Pages/chatPage.dart';
import 'package:flutterchat/Pages/loginPage.dart';
import 'package:flutterchat/Pages/registrationPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  width: 100.0,
                  child: Image.asset(
                    'assets/LogoChat.png',
                  ),
                ),
              ),
              Text(
                'Flutter Chat',
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          CustomButton(
            text: 'Log In',
            callback: () {
              Navigator.of(context).pushNamed(Login.id);
            },
          ),
          CustomButton(
            text: 'Register',
            callback: () {
              Navigator.of(context).pushNamed(Registration.id);
            },
          ),
          Container(
            child: Text('Ren Frost inc.'),
            alignment: Alignment(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Material(
        color: Color.fromRGBO(90, 54, 204, 5),
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 45.0,
          child: Text(text),
        ),
      ),
    );
  }
}
