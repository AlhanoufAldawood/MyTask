import 'dart:async';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

//import '../widgets/ui_elements/title_default.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);



  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      print('Back button pressed!');
      Navigator.pop(context, false);
      return Future.value(false);
    },
        child: ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Child product = model.allProducts[productIndex];
        return Scaffold(
            appBar: AppBar(
              title: Text(product.name),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage('assets/Welcomebackground.png'),),),
              padding: EdgeInsets.all(10.0),

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(imageUrl),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(top: 70.0),
                        child:

                        Center(
                            child:
                            Column(children: <Widget>[
                              Text(product.name + ' has no tasks',
                                style: new TextStyle(fontSize: 20.0,
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),


                              // Text( _childUser ),
                              //Text( _childPassword ),


                            ],
                            )
                        )
                    )
                  ]
              ),

            )
        );
      }
        )

        );


  }
}
