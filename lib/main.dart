import 'package:erie/register-service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './erie-register.dart';
import './feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ERIE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    setState(() {
      loading = true;
    });
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);

    setState(() {
      loading = false;
    });
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            Text(
              'E.R.I.E',
              style: TextStyle(
                  fontSize: 48.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 90.0),
              child: RaisedButton(
                color: Colors.white,
                child: Text(loading ? 'Loading...' : 'Sign in with Google'),
                onPressed: 
                loading
                    ? () {}
                    : () async {
                      
                        FirebaseUser user = await _handleSignIn();
                        RegisterService regService = new RegisterService();
                        
                        
                        if(!await regService.userExist(user.uid)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyRegister(user)),
                        );
                        } else {
                            Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFeedbackList()),
                        ); 
                        }
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}
