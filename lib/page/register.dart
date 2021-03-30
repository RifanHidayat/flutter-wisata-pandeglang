

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:wisatapandeglang/validasi/validator.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

enum statusLogin { signIn, notSignIn }

class _RegisterState extends State<Register> {



  var Cemail = new TextEditingController();
  var Cusername = new TextEditingController();

  var Cnama = new TextEditingController();
  var Cpassword = new TextEditingController();
  var Cphone = new TextEditingController();


  Validasi validasi = new Validasi();



  Widget _buildEmailTF() {
    return Container(
      child: TextFormField(
        controller: Cemail,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Theme.of(context).cursorColor,

        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'Email',
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

          validasi.validasi_register(context, Cnama.text, Cemail.text,Cusername.text,Cpassword.text);


        },
        child: Text('Register'),
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

  Widget _buildUsername() {
    return Container(
      child: TextFormField(
        controller: Cusername,
        keyboardType: TextInputType.name,
        // ignore: deprecated_member_use
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

  Widget _buildnama() {
    return Container(

      child: TextFormField(
        controller: Cnama,
        // ignore: deprecated_member_use
        cursorColor: Theme.of(context).cursorColor,

        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.person_outline),
          labelText: 'Nama',
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



  @override
  Widget build(BuildContext context) {

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
                    vertical: 50.0,
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        _buildnama(),
                        _buildUsername(),
                        _buildEmailTF(),

                        _buildPasswordTF(),
                        SizedBox(height: 25,),

                        _buildLoginBtn(),




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

  }


  @override
  void initState() {

    super.initState();
  }
}
