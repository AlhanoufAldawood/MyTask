import 'package:flutter/material.dart';

import '../widgets/products/children.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/logout.dart';

class ProductsPage extends StatefulWidget {

  final MainModel model;
  ProductsPage(this.model);

  State<StatefulWidget> createState(){
    return _ProductPageState();
  }
}

class _ProductPageState extends State<ProductsPage>{

  @override
  initState(){
    widget.model.fetchData();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(

      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.blueGrey,
            automaticallyImplyLeading: false,
            title: Text('Choose',
            style: new TextStyle(color: Colors.white),),
          ),

      ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Childern'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          Divider(),
          LogoutTile(),
        ],
      ),
    );
  }

  Widget _buildChildernList(){
    return ScopedModelDescendant(builder: (BuildContext context , Widget child, MainModel model)
    {
      Widget content = Center(child: Text('No childern found :('));
       if (model.allProducts.length > 0 && !model.isloading){

         content = Products();
      } else if (model.isloading){
         content = Center(child: CircularProgressIndicator());
       }
     return  content ;
    });
        // LECTURE 172 from 5:00

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: _buildSideDrawer(context),

      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Parents Home Page',
        style: new TextStyle(color: Colors.white),
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

      child: _buildChildernList(),
      ));
  }
}
