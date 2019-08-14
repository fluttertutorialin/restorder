import 'package:flutter/material.dart';
import 'package:restorder/ui/pages/dashboard/dashboard_page.dart';
import 'package:restorder/ui/widgets/background_clipper.dart';
import 'package:restorder/ui/widgets/custom_floating_action_button.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController name = new TextEditingController();
  final TextEditingController phoneNumber = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController rePassword = new TextEditingController();

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    //selectedUser = genders[0];
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      body: new ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[signUpHeader(), formUI()],
      ),
    );
  }

  @override
  void dispose() {
    if (this.mounted) super.dispose();
  }

  signUpHeader() => Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Text(
              "Create New Account",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                  fontSize: 22.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Free",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            SizedBox(
              height: 20.0,
            )
          ]);

  Widget formUI() {
    return new Container(
        child: Stack(children: <Widget>[
      ClipPath(
          clipper: BackgroundClipper(),
          child: Container(
              height: 500,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      height: 60.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                      child: TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'Name',
                          labelText: "Name",
                        ),
                        keyboardType: TextInputType.text,
                        controller: name,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Email',
                            labelText: "Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Password',
                            labelText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                semanticLabel: _obscureText
                                    ? 'show password'
                                    : 'hide password',
                              ),
                            ),
                          ),
                          obscureText: _obscureText,
                          controller: password,
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Confirm password',
                            labelText: "Confirm password",
                          ),
                          obscureText: _obscureText,
                          controller: rePassword,
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Mobile',
                            labelText: "Mobile",
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            MaskedTextInputFormatterShifter(
                                maskONE: "XXX XXX XXXX",
                                maskTWO: "XXX XXX XXXX"),
                          ],
                          controller: phoneNumber,
                        )),
                    new SizedBox(height: 15.0),
                  ]))),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey.withOpacity(0.2),
          child: Icon(Icons.person_add, color: Colors.black),
        )
      ]),
      Container(
          height: 530,
          child: Align(
              alignment: Alignment.bottomCenter,
              /*child: RaisedButton(
                    elevation: 0.0,
                    splashColor: Colors.orangeAccent,
                    padding: EdgeInsets.all(12.0),
                    shape: StadiumBorder(),
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Raleway'),
                    ),
                    color: Colors.orange,*/
              child: CustomFloatingActionButton(
                  icon: Icons.navigate_next,
                  isMini: false,
                  qrCallback: () async {
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new DashboardPage()),
                    );
                    //verifyDetails();
                  })))
    ]));
  }
}
