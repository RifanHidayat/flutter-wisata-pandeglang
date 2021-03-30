
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wisatapandeglang/auth/authentication.dart';
import 'package:wisatapandeglang/page/login.dart';
import 'package:wisatapandeglang/page/updateProfile.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

enum statusLogin { signIn, notSignIn }

class _ProfileState extends State<Profile> {
  statusLogin _loginStatus = statusLogin.notSignIn;
  @override
String photo,nama,email,username,telp,id;
  String tes;
  int value;

  Widget _photoProfile(){
    return Container(
      margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 10),
      child:Center(
        child: Container(
          margin: EdgeInsets.all(20),

          child: Row(
          children: <Widget>[
          CircleAvatar(
          backgroundImage: (photo != null)
              ? NetworkImage(
            photo,
            //Constants.images[Random().nextInt(Constants.images.length)],
          )
              : NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/wisata-a25b6.appspot.com/o/images%2Fd6d457f5-bc58-4da3-bef3-cbe6209ddbae?alt=media&token=d68f8bd5-5cea-4ea1-a5c5-48af24d4c4d8"),

            radius: 50.0,
          backgroundColor: Colors.transparent,
        ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                children: <Widget>[
                  Text("$nama",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,

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

  Widget _detailProfile(){
    return Container(
      margin: EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 20),
      child: Column(
        children: <Widget>[
          Container(

            child: Row(

              children: <Widget>[
                Icon(Icons.person,color: Colors.black38,),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Username",
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5,),
                      Text("$username",style: TextStyle(
                          color:Colors.black
                      ),),


                    ],

                  ),
                )

              ],
            ),

          ),
          const Divider(
            color: Colors.black38,
            height: 20,

            thickness: 1,
            indent: 40,
            endIndent: 0,
          ),
          SizedBox(height: 20,),
          Container(

           child: Row(

             children: <Widget>[
               Icon(Icons.email,color: Colors.black38,),
               Container(
                 margin: EdgeInsets.only(left: 20),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("Email",
        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5,),
      Text("$email",style: TextStyle(
        color:Colors.black
      ),),


    ],
    
    ),
               )

             ],
           ),

          ),
          const Divider(
            color: Colors.black38,
            height: 20,

            thickness: 1,
            indent: 40,
            endIndent: 0,
          ),
          SizedBox(height: 20,),


        ],
      ),
    );
  }
  Widget _buildLoginLogout() {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 20),
      width: double.infinity,
      height: 40,
      child: OutlineButton(

        onPressed: () {
          logout();

        },
        child: Text('Logout'),
      ),
    );

  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(
                color: Colors.black87
            )
        ),
        elevation: 1,
        backgroundColor: Colors.white,

        //Menambahkan Beberapa Action Button
        actions: <Widget>[

          new IconButton(icon: new Icon(Icons.edit, color: Colors.black), onPressed: () {
            Navigator
                .push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext
                  context) =>UpdateProfile(
                    nameU: nama,
                    emailU: email,
                    usernameU: username,
                    photo: photo,
                    id: id,
                  )

              ),);

          },),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _photoProfile(),
              _detailProfile(),

              _buildLoginLogout()
            ],
          ),

        ),
      ),
    );
  }
  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
      signOutUser();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Login()),
        ModalRoute.withName('/Login'),
      );
    });
  }


  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getInt("value");

      nama = sharedPreferences.getString("nama");
      username = sharedPreferences.getString("username");
      email = sharedPreferences.getString("email");
      telp = sharedPreferences.getString("phone");
      photo = sharedPreferences.getString("photo");
      id = sharedPreferences.getString("id");

    });
  }

  @override
  void initState() {
    setState(() {
      getDataPref();

    });

    super.initState();
  }

}
