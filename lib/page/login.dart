//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:travel/auth/authentication.dart';
//
//
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         height: double.infinity,
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 Image.asset(
//                   "assets/images/logo1.png",
//                   width: double.maxFinite,
//                   height: 300,
//                   fit: BoxFit.fill,
//                 ),
//                 Container(
//                   width: double.maxFinite,
//                   height: 300,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       new MaterialButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: () => googleSignIn().whenComplete(() async {
//                           FirebaseUser user =
//                           await FirebaseAuth.instance.currentUser();
//
//                           // Navigator.pushAndRemoveUntil(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (BuildContext context) => Root()),
//                           //     ModalRoute.withName('/LoginScreen'));
//                         }),
//                         child: Image(
//                           image: AssetImage('assets/images/signin.png'),
//                           width: 200.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisatapandeglang/auth/authentication.dart';
import 'package:wisatapandeglang/page/navbar.dart';
import 'package:wisatapandeglang/page/register.dart';
import 'package:wisatapandeglang/validasi/validator.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum statusLogin { signIn, notSignIn }

class _LoginState extends State<Login> {

  statusLogin _loginStatus = statusLogin.notSignIn;

  var Cusername = new TextEditingController();

  var Cpassword = new TextEditingController();
  Validasi validasi = new Validasi();



  Widget _buildEmailTF() {
    return Container(
      child: TextFormField(
        controller: Cusername,
        cursorColor: Theme.of(context).cursorColor,

        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          labelText: 'Username',
          labelStyle: TextStyle(
            color: Colors.black87,
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Container(
      child: TextFormField(
        controller: Cpassword,
        obscureText: true,
        cursorColor: Theme.of(context).cursorColor,
        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.black87,
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)
          ),
        ),
      ),
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      width: double.infinity,
      height: 40,
      child: OutlineButton(

        onPressed: () {
          setState(() {
            validasi.validasi_login(context, Cusername.text, Cpassword.text);
          });
        },
        child: Text('Login'),
      ),
    );

  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          'OR',
          style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildrextregister() {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
            child: Text(
              " Have no account? Sign Up ",
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _btnSigngooge(){
  return Container(
    child: new MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () => googleSignIn().whenComplete(() async {
        FirebaseUser user =
        await FirebaseAuth.instance.currentUser();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Navbar()),
            ModalRoute.withName('/LoginScreen'));
      }),
      child: Image(
        image: AssetImage('assets/signin.png'),
        width: double.infinity,
        height: 40,

      ),
    ),
  );

}
  Widget _buildRegisterbtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Register',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:

        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,

                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 100.0,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            _buildEmailTF(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildPasswordTF(),

                            SizedBox(
                              height: 30.0,
                            ),

                            //_buildRememberMeCheckbox(),
                            _buildLoginBtn(),
                            SizedBox(
                              height: 10.0,
                            ),

                            _buildSignInWithText(),
                           // _btnSigngooge(),
                            _buildrextregister()

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return Navbar();
        break;
    }

  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {




      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
  }
}
