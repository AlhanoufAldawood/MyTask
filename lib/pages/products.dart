import 'package:flutter/material.dart';

import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(

      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text('Choose',
            style: new TextStyle(color: Colors.red[400]),),
          ),

      ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Childern'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: _buildSideDrawer(context),

      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red[400]),
        title: Text('Parents Home Page',
        style: new TextStyle(color: Colors.red[400]),
      ),
        actions: <Widget>[
         // IconButton(
           // icon: Icon(Icons.favorite),
           // onPressed: () {},
          //)
        ],
      ),
      body:Container(

    decoration: BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
    image: AssetImage('assets/Welcomebackground.png'),),),
    padding: EdgeInsets.all(10.0),

      child: Products(),
      ));
  }
}
