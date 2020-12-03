import 'package:flutter/material.dart';
import 'package:imageCollector/loading/fireload.dart';
import 'package:imageCollector/screens/parts/textfieldstyle.dart';
import 'package:imageCollector/services/authentication_service.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleHome;
  SignUpScreen({Key key, this.toggleHome}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        "images/logo.png",
                        height: 100.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5ebecd)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: TextFormField(
                        validator: (val) => val.isEmpty ? "Please Email" : null,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        decoration: textDecorationStyle.copyWith(
                          hintText: "Email Address",
                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                          //print(email);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: TextFormField(
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? "Password must be greater than 6 letters"
                              : null,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          decoration: textDecorationStyle.copyWith(
                            hintText: "Password",
                          ),
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: FlatButton.icon(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          color: Color(0xff5ebecd),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .createwithEmailPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      "You've Enter Wrong Email and Password";
                                });
                              }
                            }
                          },
                          icon: Icon(Icons.login),
                          label: Text("SignUp"),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 80.0, vertical: 4.0),
                      child: Divider(
                        color: Color(0xFF353D2F),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text("Do have an account?"),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          FlatButton(
                            onPressed: () {
                              //Navigator.pushNamed(context, 'loginscreen');
                              widget.toggleHome();
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
