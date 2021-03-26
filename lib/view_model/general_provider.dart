import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercado/constants.dart';
import 'package:mercado/model/cart_model.dart';
import 'package:mercado/model/checked_model.dart';
import 'package:mercado/model/favourite_model.dart';
import 'package:mercado/model/order_model.dart';
import 'package:mercado/model/product.dart';
import 'package:mercado/screen/favourite.dart';
import 'package:mercado/screen/cart.dart';
import 'package:mercado/screen/manage_products.dart';
import 'package:mercado/screen/order.dart';
import 'package:mercado/screen/settings.dart';
import 'package:mercado/screen/shop.dart';
import 'package:mercado/services/auth.dart';
import 'package:mercado/services/shared_preferences.dart';

class GeneralProvider with ChangeNotifier {
  int _selectedItem = 0;
  int _quantity = 1;
  StreamSubscription<ConnectivityResult> _streamSubscription;
  Connectivity _connectivity;
  CheckedModel _color, _size;
  List<CartModel> _carts = [];
  List<OrderModel> _orders = [];
  bool _isCartEmpty = true;
  bool _isOrderEmpty = true;
  bool _isProductsEmpty = true;
  bool _isProductsByUserEmpty = true;
  bool _isFavouriteEmpty = true;
  bool _productLoading = true;
  bool _favouriteLoading = true;
  bool _cartLoading = true;
  bool _orderLoading = true;
  int _selectedSignUpPage = 0;
  String _selectedTitle = 'MyShop';
  Widget _currentWidget = Shop();
  bool _isLoading = false;
  Preferences _preferences;
  AccountState _state;
  Auth _auth;
  bool _isDarkMode = true;
  int _selectedColor = 0;
  int _selectedSize = 0;
  NetworkState _networkState;
  TextEditingController _updateSettingsController,
      _loginEmailController,
      _loginPasswordController,
      _signUpEmailController,
      _signUpFullNameController,
      _signUpPasswordController,
      _signUpConfirmPasswordController;
  FocusNode _loginEmailNode,
      _loginPasswordNode,
      _signUpEmailNode,
      _signUpFullNameNode,
      _signUpPasswordNode,
      _signUpConfirmPasswordNode,
      _updateSettingsFocus;
  String _loginEmailErrorMsg,
      _loginPasswordErrorMsg,
      _signUpPasswordErrorMsg,
      _signUpConfirmPasswordErrorMsg,
      _signUpFullNameErrorMsg,
      _signUpEmailErrorMsg,
      _updateSettingsErrorMsg;
  List<Product> _products;
  List<Product> _productsByUser;
  List<FavouriteModel> _favouriteProducts = [];

  List<Product> get products => _products;

  bool get productLoading => _productLoading;

  void addQuantity() {
    _quantity++;
    notifyListeners();
  }

  void setColor(CheckedModel m) {
    _color = m;
    notifyListeners();
  }

  void setSize(CheckedModel m) {
    _size = m;
    notifyListeners();
  }

  double cartTotalAmount() {
    double total = 0.0;
    _carts.forEach((e) {
      total += (e.price * e.quantity);
    });
    return total;
  }

  void initConnectivity() {
    _connectivity = Connectivity();
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        _networkState = NetworkState.STABLE_CONNECTION;
      } else {
        _networkState = NetworkState.NO_CONNECTION;
      }
      notifyListeners();
    });
  }

  void disposeConnectivity() {
    _streamSubscription.cancel();
    _connectivity = null;
  }

  Product getProductById(String id) {
    return products.where((element) => element.id == id).toList()[0];
  }

  CheckedModel get color => _color;

  void removeQuantity() {
    if (_quantity > 0) {
      _quantity--;
    }
    notifyListeners();
  }

  void resetQuantity() {
    _quantity = 1;
    notifyListeners();
  }

  int get quantity => _quantity;

  File _imagePath;

  String _imageFilepath;

  String get imageFilepath => _imageFilepath;

  void setImageFilePath(String path) {
    _imageFilepath = path;
    notifyListeners();
  }

  NetworkState get networkState => _networkState;

  bool get isDarkMode => _isDarkMode;

  void setDarkModeState(bool value) async {
    _isDarkMode = value;
    await _preferences.setDarkMode(value);
    notifyListeners();
  }

  File get imagePath => _imagePath;

  AccountState get state => _state;

  String get loginEmailErrorMsg => _loginEmailErrorMsg;

  void initSettingsControllersAndFocus() {
    _updateSettingsController = TextEditingController();
    _updateSettingsFocus = FocusNode();
  }

  int get selectedColor => _selectedColor;

  int get selectedSize => _selectedSize;

  void setSelectedColor(int value) {
    _selectedColor = value;
    notifyListeners();
  }

  void setSelectedSize(
    int value,
  ) {
    _selectedSize = value;
    notifyListeners();
  }

  void disposeSettingsControllersAndFocus() {
    _updateSettingsController.dispose();
    _updateSettingsFocus.dispose();
  }

  void initControllersAndFocus() {
    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();
    _signUpEmailController = TextEditingController();
    _signUpFullNameController = TextEditingController();
    _signUpPasswordController = TextEditingController();
    _signUpConfirmPasswordController = TextEditingController();
    _loginEmailNode = FocusNode();
    _loginPasswordNode = FocusNode();
    _signUpEmailNode = FocusNode();
    _signUpFullNameNode = FocusNode();
    _signUpPasswordNode = FocusNode();
    _signUpConfirmPasswordNode = FocusNode();
  }

  void disposeControllerAndFocus() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signUpFullNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();
    _loginEmailNode.dispose();
    _loginPasswordNode.dispose();
    _signUpFullNameNode.dispose();
    _signUpEmailNode.dispose();
    _signUpPasswordNode.dispose();
    _signUpConfirmPasswordNode.dispose();
  }

  Future<String> imagePicker(ImageSource source) async {
    try {
      ImagePicker picker = ImagePicker();
      PickedFile file = await picker.getImage(source: source, imageQuality: 50);
      _imagePath = File(file.path);
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  void setLoginEmailErrorMsg(String value) {
    _loginEmailErrorMsg = value;
    notifyListeners();
  }

  void setLoginPasswordErrorMsg(String value) {
    _loginPasswordErrorMsg = value;
    notifyListeners();
  }

  void setSignUpFullNameErrorMsg(String value) {
    _signUpFullNameErrorMsg = value;
    notifyListeners();
  }

  void setSignUpEmailErrorMsg(String value) {
    _signUpEmailErrorMsg = value;
    notifyListeners();
  }

  void setUpdateSettingsErrorMsg(String value) {
    _updateSettingsErrorMsg = value;
    notifyListeners();
  }

  void setSignUpPasswordErrorMsg(String value) {
    _signUpPasswordErrorMsg = value;
    notifyListeners();
  }

  void setSignUpConfirmPasswordErrorMsg(String value) {
    _signUpConfirmPasswordErrorMsg = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> updatePassword(String newPassword) async {
    try {
      await _auth.user.updatePassword(newPassword);
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      await clearAll();
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  bool get isLoading => _isLoading;

  int get selectedSignUpIndex => _selectedSignUpPage;

  Widget get currentWidget => _currentWidget;

  void _changeCurrent(int i) {
    switch (i) {
      case 0:
        _currentWidget = Shop();
        break;
      case 1:
        _currentWidget = Favourite();
        break;
      case 2:
        _currentWidget = Cart();
        break;
      case 3:
        _currentWidget = Order();
        break;
      case 4:
        _currentWidget = ManageProducts();
        break;
      case 5:
        _currentWidget = Settings();
        break;
    }
  }

  void initAuth() async {
    _auth = Auth.instance;
    await _auth.initAuth();
  }

  void initPreferences() async {
    _preferences = Preferences.instance;
    await _preferences.initPref();
    loadDarkPref();
  }

  Future<String> facebookAuth() async {
    String res = await _auth.facebookAuth();
    return res;
  }

  Future<String> googleAuth() async {
    String res = await _auth.googleAuth();
    return res;
  }

  bool get favouriteLoading => _favouriteLoading;

  Future<String> createAccount(String email, String password,
      {String username, String photoUrl}) async {
    String r = await _auth.createNewAccount(
        email: email,
        password: password,
        username: username,
        imageUrl: photoUrl);
    return r;
  }

  Future<String> loginAccount(String email, String password) async {
    String r = await _auth.loginAccount(email, password);
    return r;
  }

  User get user => _auth.user;

  Future<void> accountState(String email) async {
    List<String> strings = await _auth.checkAccount(email);
    if (strings.isEmpty) {
      _state = AccountState.NOT_FOUND;
    } else {
      _state = AccountState.REGISTER;
    }
    notifyListeners();
  }

  Future<String> saveAccount(User user) async {
    try {
      await _preferences.setUserEmail(user.email);
      await _preferences.setUserId(user.uid);
      await _preferences.setUserName(user.displayName);
      if (user.photoURL != null) {
        await _preferences.setUserPhotoUrl(user.photoURL);
      }
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  void loadDarkPref() {
    _isDarkMode = _preferences.getDarkMode ?? false;
    notifyListeners();
  }

  String get getId => _preferences.getUserId;

  String get getName => _preferences.getUserName;

  String get getEmail => _preferences.getUserEmail;

  String get getImageUrl => _preferences.getUserPhotoUrl;

  bool get isFirstTime => _preferences.isFirstTime();

  Future<String> clearAll() async {
    try {
      await _preferences.clearUser();
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateProfile({String username, String photoUrl}) async {
    try {
      await _auth.user.updateProfile(displayName: username, photoURL: photoUrl);
      await saveAccount(user);
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> forgetPassword(String email) async {
    String result = await _auth.forgetPassword(email);
    return result;
  }

  void changeSelectedSignUpIndex(int i) {
    _selectedSignUpPage = i;
    notifyListeners();
  }

  void changeSelectedItem(int i, String title) {
    _selectedItem = i;
    if (title == 'Manage Products') {
      _selectedTitle = 'Your Products';
    } else {
      _selectedTitle = title;
    }
    _changeCurrent(i);
    notifyListeners();
  }

  String get selectedTitle => _selectedTitle;

  int get selectedItem => _selectedItem;

  TextEditingController get loginPasswordController => _loginPasswordController;

  TextEditingController get signUpEmailController => _signUpEmailController;

  TextEditingController get signUpFullNameController =>
      _signUpFullNameController;

  TextEditingController get signUpPasswordController =>
      _signUpPasswordController;

  TextEditingController get signUpConfirmPasswordController =>
      _signUpConfirmPasswordController;

  FocusNode get loginEmailNode => _loginEmailNode;

  FocusNode get loginPasswordNode => _loginPasswordNode;

  TextEditingController get loginEmailController => _loginEmailController;

  FocusNode get signUpEmailNode => _signUpEmailNode;

  FocusNode get signUpFullNameNode => _signUpFullNameNode;

  FocusNode get signUpPasswordNode => _signUpPasswordNode;

  FocusNode get signUpConfirmPasswordNode => _signUpConfirmPasswordNode;

  String get loginPasswordErrorMsg => _loginPasswordErrorMsg;

  String get signUpPasswordErrorMsg => _signUpPasswordErrorMsg;

  String get signUpConfirmPasswordErrorMsg => _signUpConfirmPasswordErrorMsg;

  String get signUpFullNameErrorMsg => _signUpFullNameErrorMsg;

  String get signUpEmailErrorMsg => _signUpEmailErrorMsg;

  String get updateSettingsErrorMsg => _updateSettingsErrorMsg;

  FocusNode get updateSettingsFocus => _updateSettingsFocus;

  TextEditingController get updateSettingsController =>
      _updateSettingsController;

  CheckedModel get size => _size;

  bool get isCartEmpty => _isCartEmpty;

  bool get isOrderEmpty => _isOrderEmpty;

  bool get isFavouriteEmpty => _isFavouriteEmpty;

  bool get isProductsEmpty => _isProductsEmpty;

  Future<String> addProduct(Product p) async {
    try {
      await http.post(
        Uri.parse('${baseUrl}products/$getId.json'),
        body: jsonEncode(
          {
            'title': p.title,
            'description': p.description,
            'imageUrl': p.imageUrl,
            'price': p.price,
          },
        ),
      );
      _productsByUser.add(p);
      _isProductsByUserEmpty = _productsByUser.isEmpty;
      notifyListeners();
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> setFavourite(FavouriteModel f) async {
    try {
      _favouriteProducts.add(f);
      _isFavouriteEmpty = _favouriteProducts.isEmpty;
      notifyListeners();
      await http.post(
        Uri.parse('${baseUrl}favourite/$getId.json'),
        body: jsonEncode(
          {
            'productId': f.productId,
            'title': f.title,
            'description': f.description,
            'price': f.price,
            'imageUrl': f.imageUrl,
          },
        ),
      );
      return Auth.success;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> deleteFavourite(String productId) async {
    try {
      FavouriteModel f =
          favouriteProducts.where((i) => i.productId == productId).toList()[0];
      _favouriteProducts.remove(f);
      _isFavouriteEmpty = _favouriteProducts.isEmpty;
      notifyListeners();
      await http.delete(
        Uri.parse('${baseUrl}favourite/$getId/${f.id}.json'),
      );
      return Auth.success;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  bool isFavourite(String id) => _favouriteProducts
      .where((item) => item.productId == id)
      .toList()
      .isNotEmpty;

  Future<String> updateProduct(Product p) async {
    try {
      await http.patch(
        Uri.parse('${baseUrl}products/$getId/${p.id}.json'),
        body: json.encode(
          {
            'title': p.title,
            'imageUrl': p.imageUrl,
            'description': p.description,
            'price': p.price,
          },
        ),
      );
      int productIndex = _productsByUser.indexWhere((item) => item.id == p.id);
      _productsByUser[productIndex] = p;
      notifyListeners();
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteProduct(Product p) async {
    int productIndex = _productsByUser.indexWhere((item) => item.id == p.id);
    try {
      _productsByUser.removeAt(productIndex);
      _isProductsByUserEmpty = _productsByUser.isEmpty;
      notifyListeners();
      await http.delete(
        Uri.parse('${baseUrl}products/$getId/${p.id}.json'),
      );
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getAllProducts() async {
    _products = [];
    try {
      http.Response r = await http.get(Uri.parse('${baseUrl}products.json'));
      final Map<String, dynamic> data =
          json.decode(r.body) as Map<String, dynamic>;
      if (data != null) {
        data.forEach(
          (k, v) {
            (v as Map<String, dynamic>).forEach(
              (key, val) {
                _products.add(
                  Product(
                    id: key,
                    title: val['title'],
                    description: val['description'],
                    price: val['price'],
                    imageUrl: val['imageUrl'],
                  ),
                );
              },
            );
          },
        );
        return Auth.success;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getFavouriteByUser() async {
    _favouriteProducts = [];
    try {
      http.Response r =
          await http.get(Uri.parse('${baseUrl}favourite/$getId.json'));
      final Map<String, dynamic> data =
          json.decode(r.body) as Map<String, dynamic>;
      if (data != null) {
        data.forEach(
          (k, v) {
            _favouriteProducts.add(
              FavouriteModel(
                id: k,
                productId: v['productId'],
                title: v['title'],
                description: v['description'],
                imageUrl: v['imageUrl'],
                price: v['price'],
              ),
            );
          },
        );
        return Auth.success;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  List<FavouriteModel> get favouriteProducts => _favouriteProducts;

  Future<String> getProductsByUser() async {
    _productsByUser = [];
    try {
      http.Response r =
          await http.get(Uri.parse('${baseUrl}products/$getId.json'));
      final Map<String, dynamic> data =
          json.decode(r.body) as Map<String, dynamic>;
      if (data != null) {
        data.forEach(
          (k, v) {
            _productsByUser.add(
              Product(
                id: k,
                title: v['title'],
                description: v['description'],
                price: v['price'],
                imageUrl: v['imageUrl'],
              ),
            );
          },
        );
        return Auth.success;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addOrder(OrderModel order) async {
    try {
      await http.post(
        Uri.parse('${baseUrl}orders/$getId.json'),
        body: json.encode(
          {
            'amount': order.amount,
            'dateTime': order.dateTime.toIso8601String(),
            'cartItems': order.products
                .map((model) => {
                      'productId': model.productId,
                      'title': model.title,
                      'imageUrl': model.imageUrl,
                      'price': model.price,
                      'quantity': model.quantity,
                      'description': model.description,
                    })
                .toList(),
          },
        ),
      );
      _orders.add(order);
      notifyListeners();
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getAllOrders() async {
    _orders = [];
    try {
      http.Response r =
          await http.get(Uri.parse('${baseUrl}orders/$getId.json'));
      final Map<String, dynamic> data =
          json.decode(r.body) as Map<String, dynamic>;
      if (data != null) {
        data.forEach(
          (k, v) {
            _orders.add(
              OrderModel(
                id: k,
                amount: v['amount'],
                dateTime: DateTime.parse(v['dateTime']),
                products: (v['cartItems'] as List<dynamic>).map(
                  (cart) {
                    return CartModel.withoutId(
                      description: cart['description'],
                      imageUrl: cart['imageUrl'],
                      price: cart['price'],
                      title: cart['title'],
                      quantity: cart['quantity'],
                      productId: cart['productId'],
                    );
                  },
                ).toList(),
              ),
            );
          },
        );
        return Auth.success;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addCart(CartModel model) async {
    try {
      await http.post(
        Uri.parse('${baseUrl}carts/$getId.json'),
        body: json.encode(
          {
            'productId': model.productId,
            'title': model.title,
            'imageUrl': model.imageUrl,
            'price': model.price,
            'quantity': model.quantity,
            'description': model.description,
          },
        ),
      );
      _carts.add(model);
      notifyListeners();
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteCart(String id, bool fromDetails) async {
    String cartId;
    int cartIndex;
    if (fromDetails) {
      cartIndex = _carts.indexWhere((item) => item.productId == id);
      CartModel cart = _carts.firstWhere((item) => item.productId == id);
      cartId = cart.id;
    } else {
      cartId = id;
      cartIndex = carts.indexWhere((item) => item.id == cartId);
    }
    try {
      carts.removeAt(cartIndex);
      _isCartEmpty = _carts.isEmpty;
      notifyListeners();
      await http.delete(
        Uri.parse('${baseUrl}carts/$getId/$cartId.json'),
      );
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getAllCarts() async {
    _carts = [];
    try {
      http.Response r =
          await http.get(Uri.parse('${baseUrl}carts/$getId.json'));
      final Map<String, dynamic> data =
          json.decode(r.body) as Map<String, dynamic>;
      if (data != null) {
        data.forEach(
          (k, v) {
            _carts.add(
              CartModel(
                id: k,
                productId: v['productId'],
                title: v['title'],
                description: v['description'],
                price: v['price'],
                imageUrl: v['imageUrl'],
                quantity: v['quantity'],
              ),
            );
          },
        );
        return Auth.success;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteAllCarts() async {
    try {
      _carts.clear();
      _isCartEmpty = _carts.isEmpty;
      notifyListeners();
      await http.delete(
        Uri.parse('${baseUrl}carts/$getId.json'),
      );
      return Auth.success;
    } catch (e) {
      return e.toString();
    }
  }

  bool isCart(String id) =>
      _carts.where((item) => item.productId == id).toList().isNotEmpty;

  List<CartModel> get carts => _carts;

  List<OrderModel> get orders => _orders.reversed.toList();

  void getFavourites() async {
    _favouriteLoading = true;
    await getFavouriteByUser();
    _favouriteLoading = false;
    _isFavouriteEmpty = _favouriteProducts.isEmpty;
    notifyListeners();
  }

  void getProducts() async {
    _productLoading = true;
    await getAllProducts();
    _productLoading = false;
    _isProductsEmpty = _products.isEmpty;
    notifyListeners();
  }

  void getUserProducts() async {
    _productLoading = true;
    await getProductsByUser();
    _productLoading = false;
    _isProductsByUserEmpty = _productsByUser.isEmpty;
    notifyListeners();
  }

  bool get isProductsByUserEmpty => _isProductsByUserEmpty;

  void getCarts() async {
    _cartLoading = true;
    await getAllCarts();
    _cartLoading = false;
    _isCartEmpty = _carts.isEmpty;
    notifyListeners();
  }

  void getOrders() async {
    _orderLoading = true;
    await getAllOrders();
    _orderLoading = false;
    _isOrderEmpty = _orders.isEmpty;
    notifyListeners();
  }

  Future<void> clearProductList() async {
    _products.clear();
    notifyListeners();
    await getAllProducts();
    notifyListeners();
  }

  bool get cartLoading => _cartLoading;

  bool get orderLoading => _orderLoading;

  List<Product> get productsByUser => _productsByUser;
}
