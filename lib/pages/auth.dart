import 'package:flutter/material.dart';
import './signin.dart';
import './signup.dart';


// هذي الصفحة فيها التابز حقت الساين ان و الساين اب
// مربوطة ب signin.dart and signup.dart


class Auth extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

   // final double deviceWidth = MediaQuery.of(context).size.width;
    //final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return DefaultTabController(
      length: 2,
      child:
      Scaffold(
        appBar:
        AppBar(
          backgroundColor: Colors.blueGrey,
        title:  Text('Home' ,
          style: new TextStyle(color: Colors.white) ,),
         bottom:
        TabBar (

          labelColor: Colors.white,
          indicatorColor: Colors.blueGrey,

          tabs: <Widget>[
            Tab(

              //icon: Icon(Icons.person),
              text: 'Sign In',),


            Tab(
             // icon: Icon(Icons.person_add),
              text: 'Sign Up',),
          ],),

        ),
        body: TabBarView(children: <Widget>[
          SignIn(),
          Signup(),


        ]),
    ),

    );
  }
}