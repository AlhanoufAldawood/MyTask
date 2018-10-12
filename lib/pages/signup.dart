import 'package:flutter/material.dart';


class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {

  String _username;
  String _emailValue;
  String _passwordValue;
  String _confirmpassword;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage('assets/Welcome background.png'),),),
          padding: EdgeInsets.all(10.0),

          child: Center(

        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              TextField(

                decoration: InputDecoration(labelText: 'Name',filled: true, fillColor: Colors.white70),

                onChanged: (String value) {
                  setState(() {
                    _username = value;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),

              TextField(
            decoration: InputDecoration(labelText: 'E-Mail' ,filled: true, fillColor: Colors.white70),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _emailValue = value;
        });
      },
    ),
    SizedBox(
    height: 10.0),

    TextField(
    decoration: InputDecoration(labelText: 'Password' ,filled: true, fillColor: Colors.white70),
    obscureText: true,
    onChanged: (String value) {
    setState(() {
    _passwordValue = value;
    });
    },
    ),
              SizedBox(
                height: 10.0,
              ),

              TextField(
                decoration: InputDecoration(labelText: 'Confirm Password' ,filled: true, fillColor: Colors.white70),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _confirmpassword = value;
                  });
                },
              ),


              SizedBox(
    height: 40.0,
    ),
    RaisedButton(
    color: Theme.of(context).primaryColor,
    textColor: Colors.white,
    child: Text('SIGN UP'),
    onPressed: () {

    Navigator.pushReplacementNamed(context, '/products');
    },
    ),
  ]

        )
    )
    )
    )
    );


  }
}
