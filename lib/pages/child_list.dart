import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './child_edit.dart';
import '../scoped-models/main.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState(){
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage>{

  @override
  initState(){
    widget.model.fetchData();
        super.initState();
  }

  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                image: AssetImage('assets/Welcomebackground.png'),),),
            padding: EdgeInsets.all(10.0),

        child :ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allProducts[index].name),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  print('Swiped start to end');
                } else {
                  print('Other swiping');
                }
              },
              background:
              Container(color: Colors.red),
              child: Column(
                children: <Widget>[
                  ListTile(
                   // leading:
                 // CircleAvatar(
                      //backgroundImage: AssetImage(model.products[index].image),
                   // ),
                    title: Text(model.allProducts[index].name),
                   // subtitle:
                       // Text('\$${model.products[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        )) );
      },
    );
  }
}
