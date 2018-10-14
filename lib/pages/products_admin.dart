import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductsAdminPage extends StatelessWidget {

    final MainModel model ;

   ProductsAdminPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.blueGrey,
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Childern list'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Childern'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.add_circle),
                text: 'Create Child profile',
              ),
              Tab(
                icon: Icon(Icons.edit),
                text: 'Edit Child profile',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[ProductEditPage(), ProductListPage(model)],
        ),
      ),
    );
  }
}
