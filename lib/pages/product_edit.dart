import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure_visible.dart';
import '../models/product.dart';
import '../scoped-models/products.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'name': null,
    'gender': null,
    'age': null,
    'user' : null,
    'password': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _userFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();





  Widget _buildNameTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _nameFocusNode,

      child: TextFormField(
        focusNode: _nameFocusNode,
        decoration: InputDecoration(labelText: 'Child Name'),
        initialValue: product == null ? '' : product.name,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty ) {
            return 'Name is required';
          }
        },
        onSaved: (String value) {
          _formData['name'] = value;
        },
      ),
    );
  }


  Widget _buildGenderTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _genderFocusNode,

      child: TextFormField(
        focusNode: _genderFocusNode,

        decoration: InputDecoration(labelText: 'Child gender'),
        initialValue: product == null ? '' : product.gender,
        //validator: (String value) {
          // if (value.trim().length <= 0) {
          //if (value.isEmpty || value.length < 10) {
           // return 'Description is required and should be 10+ characters long.';
         // }
       // },
        onSaved: (String value) {
          _formData['gender'] = value;
        },
      ),
    );
  }

  Widget _buildAgeTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _ageFocusNode,
      child: TextFormField(
        focusNode: _ageFocusNode,
        keyboardType: TextInputType.number,

        decoration: InputDecoration(labelText: 'Child age'),
        initialValue: product == null ? '' : product.age.toString(),
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if ( !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Age should be a number.';
          }
        },
        onSaved: (String value) {
          _formData['age'] = double.parse(value);
        },
      ),
    );
  }

  Widget _buildUserTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _userFocusNode,

      child: TextFormField(
        focusNode: _userFocusNode,
        decoration: InputDecoration(labelText: 'Child user name'),
        initialValue: product == null ? '' : product.user,

        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty ) {
            return 'User name is required';
          }
        },
        onSaved: (String value) {
          _formData['user'] = value;
        },
      ),
    );
  }

  Widget _buildPasswordTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _passwordFocusNode,

      child: TextFormField(
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(labelText: 'child password'),
        initialValue: product == null ? '' : product.password,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length < 5) {
            return 'Password is required and should be 5+ characters long.';
          }
        },
        onSaved: (String value) {
          _formData['password'] = value;
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return RaisedButton(
          child: Text('Save'),
          textColor: Colors.white,
          onPressed: () => _submitForm(model.addProduct, model.updateProduct,
              model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildNameTextField(product),
              _buildGenderTextField(product),
              _buildAgeTextField(product),
              _buildUserTextField(product),
              _buildPasswordTextField(product),

              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('My Button'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(
        Product(
            name: _formData['name'],
            gender: _formData['gender'],
            age: _formData['age'],
            user: _formData['user'],
            password: _formData['password']),

    );
    } else {
      updateProduct(
        Product(
            name: _formData['name'],
            gender: _formData['gender'],
            age: _formData['age'],
            user: _formData['user'],
            password: _formData['password']),
      );
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {

        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage('assets/Welcomebackground.png'),),),
              padding: EdgeInsets.all(10.0),
        child: model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              ),
          ) ); },
     );
  }
}
