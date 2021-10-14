
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mplacementtracker/common/theme_helper.dart';
import 'package:mplacementtracker/model/user.dart';
import 'package:mplacementtracker/services/authenticate.dart';
import 'package:mplacementtracker/services/helper.dart';
import '../constants.dart';
import '../main.dart';
import 'Student/student_profile.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? email, password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container( 
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    // ignore: prefer_const_constructors
                    Text(
                      'Hello',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
                    // ignore: prefer_const_constructors
                    Text(
                      'Signin into syour account',
                      style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 30.0),
                    Form(
                      key: _key,
                      autovalidateMode: _validate,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                
                                 validator: validateEmail,
                    onSaved: (val) => email = val,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    style: TextStyle(fontSize: 18.0),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(COLOR_PRIMARY),
                    decoration: InputDecoration(
                        contentPadding:
                            new EdgeInsets.only(left: 16, right: 16),
                        fillColor: Colors.white,
                        hintText: 'E-mail Address',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Color(COLOR_PRIMARY), width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextFormField(
                               validator: validatePassword,
                    onSaved: (val) => password = val,
                    onFieldSubmitted: (password) async {
                      await login();
                    },
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontSize: 18.0),
                    cursorColor: Color(COLOR_PRIMARY),
                    decoration: InputDecoration(
                        contentPadding:
                            new EdgeInsets.only(left: 16, right: 16),
                        fillColor: Colors.white,
                        hintText: 'Password',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Color(COLOR_PRIMARY), width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )))),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                },
                                child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ), ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: () => login(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
  login() async {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState!.save();
      await _loginWithEmailAndPassword();
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  _loginWithEmailAndPassword() async {
    await showProgress(context, 'Logging in, please wait...', false);
    dynamic result = await FireStoreUtils.loginWithEmailAndPassword(
        email!.trim(), password!.trim());
    await hideProgress();
    if (result != null && result is User) {
      MyAppState.currentUser = result;
      pushAndRemoveUntil(context, StudentProfile(user: result), false);
    } else if (result != null && result is String) {
      showAlertDialog(context, 'Couldn\'t Authenticate', result);
    } else {
      showAlertDialog(
          context, 'Couldn\'t Authenticate', 'Login failed, Please try again.');
    }
  }
}