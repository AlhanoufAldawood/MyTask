import 'package:flutter/material.dart';

class signin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SigninState();
  }
}

class _SigninState extends State<signin> {
  String _emailValue;
  String _passwordValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
            image: AssetImage('assets/Welcome background.png'),),),
        padding: EdgeInsets.all(10.0),


        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                  height: 40.0,
                ),
                RaisedButton(
                  color: Colors.white,
                  textColor: Colors.red[200],
                  child: Text('LOGIN'),
                  onPressed: () {
                    print(_emailValue);
                    print(_passwordValue);
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                ),
                FlatButton(
                  child: Text('Forget password?'),
                  onPressed: (){},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
