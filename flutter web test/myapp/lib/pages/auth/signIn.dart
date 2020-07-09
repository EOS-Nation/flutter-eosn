import 'package:flutter/material.dart';
import 'package:myapp/commons/loading.dart';
import 'package:myapp/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading;
  String errorMessage;
  String email;
  String password;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    errorMessage = '';
    email = '';
    password = '';
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0.0,
              leading: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/eos_nation_logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text('Sign in to EOS Nation Mobile'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: new TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).buttonColor, width: 3.0),
                        ),
                      ),
                      validator: (email) {
                        return !email.contains('@') || email.isEmpty
                            ? 'Invalid email'
                            : null;
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 14.0),
                    TextFormField(
                      style: new TextStyle(color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).buttonColor, width: 3.0),
                        ),
                      ),
                      validator: (password) {
                        return password.length < 6 ? 'Invalid password' : null;
                      },
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 9.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).buttonColor,
                              child: Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => isLoading = true);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  setState(() => isLoading = false);
                                  if (result == null) {
                                    setState(() {
                                      errorMessage =
                                          'Could not sign in with those credentials';
                                    });
                                  }
                                }
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).buttonColor,
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => isLoading = true);
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  setState(() => isLoading = false);
                                  if (result == null) {
                                    setState(() {
                                      errorMessage =
                                          'Please supply a valid email';
                                    });
                                  }
                                }
                              }),
                        ),
                        SizedBox(width: 8.0),
                        RaisedButton(
                            color: Theme.of(context).buttonColor,
                            child: Text(
                              'Sign In anonymously',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              setState(() => isLoading = true);
                              dynamic result = await _auth.signInAnonymously();
                              setState(() => isLoading = false);
                              if (result == null) {
                                setState(() {
                                  errorMessage = 'Could not sign in';
                                });
                              }
                            }),
                      ],
                    ),
                    Text(
                      errorMessage,
                      style: TextStyle(
                          color: Theme.of(context).buttonColor, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
