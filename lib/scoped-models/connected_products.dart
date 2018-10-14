import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../models/user.dart';
import '../models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectedProductsModel extends Model {
  List<Child> _childern = [];
  int _selProductIndex;
  User _authenticatedUser;
  bool _isLoading = false;

  Future<Null> addProduct(
      String name, String gender, double age, String user, String password) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> childData = {
      'name': name,
      'gender': gender,
      'age': age,
      'user': user,
      'password': password,
      'parentEmail': _authenticatedUser.email,
      'parentId': _authenticatedUser.id,
    };
    return http
        .post(
            'https://mytask-8c4b1.firebaseio.com/childern.json?auth=${_authenticatedUser.token}',
            body: json.encode(childData))
        .then((http.Response response) {
      _isLoading = false;
      final Map<String, dynamic> responseData = json.decode(response.body);

      final Child newchild = Child(
          id: responseData['name'],
          name: name,
          gender: gender,
          age: age,
          user: user,
          password: password,
          parentEmail: _authenticatedUser.email,
          parentId: _authenticatedUser.id);

      _childern.add(newchild);
      notifyListeners();
    });
  }
}

class ProductsModel extends ConnectedProductsModel {
  List<Child> get allProducts {
    return List.from(_childern);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Child get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _childern[selectedProductIndex];
  }

  Future<Null> updateProduct(
      String name, String gender, double age, String user, String password) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'name': name,
      'gender': gender,
      'age': age,
      'user': user,
      'password': password,
      'parentEmail': _authenticatedUser.email,
      'parentId': _authenticatedUser.id,
    };
    return http
        .put(
            'https://mytask-8c4b1.firebaseio.com/childern/${selectedProduct.id}.json?auth=${_authenticatedUser.token}',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      final Child updatedChild = Child(
          id: selectedProduct.id,
          name: name,
          gender: gender,
          age: age,
          user: user,
          password: password,
          parentEmail: selectedProduct.parentEmail,
          parentId: selectedProduct.parentId);
      _childern[selectedProductIndex] = updatedChild;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _isLoading = true;

    final deletedChildId = selectedProduct.id;

    _childern.removeAt(selectedProductIndex);
    _selProductIndex = null;
    notifyListeners();

    http
        .delete(
            'https://mytask-8c4b1.firebaseio.com/childern/${deletedChildId}.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void fetchData() {
    _isLoading = true;
    notifyListeners();
    http
        .get(
            'https://mytask-8c4b1.firebaseio.com/childern.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      final List<Child> fetchedChildList = [];

      final Map<String, dynamic> childListData = json.decode(response.body);

      if (childListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      childListData.forEach((String childId, dynamic childData) {
        final Child child = Child(
          id: childId,
          name: childData['name'],
          gender: childData['gender'],
          age: childData['age'],
          user: childData['user'],
          password: childData['password'],
          parentEmail: childData['parentEmail'],
          parentId: childData['parentId'],
        );

        fetchedChildList.add(child);
      });
      _childern = fetchedChildList;
      notifyListeners();
    });
  }

  void selectProduct(int index) {
    _selProductIndex = index;
  }
}

class UserModel extends ConnectedProductsModel {

  User get user{

    return _authenticatedUser;
  }



  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final http.Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyAzUK3qTHibEFZiH5TYLkQNCqvhxjlaAz4',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);

    bool hasError = true;
    String message = 'Somthing went wrong';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authenticaton sucecede';

      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);

    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Email not found !!';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'invalid password !!';
    }

    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final http.Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyAzUK3qTHibEFZiH5TYLkQNCqvhxjlaAz4',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});
    final Map<String, dynamic> responseData = json.decode(response.body);

    bool hasError = true;
    String message = 'Somthing went wrong';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authenticaton suceceded';

      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);


    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email is already exists';
    }

    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if(token != null){
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');

      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      notifyListeners();
    }


  }

  void logout() async{
    _authenticatedUser = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');

  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isloading {
    return _isLoading;
  }
}
