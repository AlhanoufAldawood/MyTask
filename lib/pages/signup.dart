import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';


class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {

  final Map<String, dynamic> _formData = {

    'name': null,
    'email': null,
    'password': null,
  };

 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  DecorationImage _buildBackgroundImage() {

    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/Welcome background.png'),);
  }

  Widget _buildNameTextField() {

   return TextFormField(

      decoration: InputDecoration(
          labelText:'Name',
          filled: true,
          fillColor: Colors.white70),

      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildEmailTextField() {

    return TextFormField(

      decoration: InputDecoration(labelText: 'E-Mail',
          filled: true,
          fillColor: Colors.white70),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {

   return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white70),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password is required and should be 5+ characters long.';
        }
      },

      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {

   return  TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password',
          filled: true,
          fillColor: Colors.white70),
      obscureText: true,
      validator: (String value){
        if(_passwordTextController.text != value)
          return 'password do not match';

      },


    );
  }




    void _submitForm(Function signUp) async {
    if (!_formKey.currentState.validate() ) {
      return;
    }
    _formKey.currentState.save();
   final Map<String , dynamic> successInformation = await signUp(_formData['email'], _formData['password']);
   if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/products');
   } else{
     showDialog(context: context,builder: (BuildContext context){
       return AlertDialog(
         title:Text( 'Somthing wrong!!'),
         content: Text( successInformation['message']), actions: <Widget>[

         FlatButton(child: Text('OK'), onPressed: (){
           Navigator.of(context).pop();
         },)
       ],);

     });
   }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(

        body: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage()),

          padding: EdgeInsets.all(10.0),


             child: Center(
               child: SingleChildScrollView(
                  child: Container(
                      width: targetWidth,

                         child: Form(
                            key: _formKey,
                                child: Column(

                           children: <Widget>[


                     _buildNameTextField(),

                           SizedBox(
                             height: (10.0),
                             ),

                        _buildEmailTextField(),



        SizedBox(
            height: 10.0
        ),


        _buildPasswordTextField(),

        SizedBox(
          height: 10.0,
        ),


        _buildConfirmPasswordTextField(),

        SizedBox(
          height: 40.0,
        ),
    ScopedModelDescendant <MainModel>(builder:(BuildContext context , Widget child , MainModel model) {
    return model.isloading ? CircularProgressIndicator() :
    RaisedButton(
    color: Colors.blueGrey,
    textColor: Colors.white,
    child: Text('SIGN UP'),
    onPressed: () => _submitForm(model.signUp),
    );
    }
    ),

        ]
    )))
    )
    )));

  }
}
