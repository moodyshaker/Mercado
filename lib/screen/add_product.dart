import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mercado/model/product.dart';
import 'package:mercado/services/auth.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/confirm_dialog.dart';
import 'package:mercado/widgets/image_picker_dialog.dart';
import 'package:mercado/widgets/no_connection_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class AddProduct extends StatefulWidget {
  static const String id = 'ADD_PRODUCT';
  final Product p;

  AddProduct({
    this.p,
  });

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _id, _title, _description, _price, _imageUrl;
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.initConnectivity();
    if (widget.p != null) {
      _id = widget.p.id;
      _title = widget.p.title;
      _description = widget.p.description;
      _price = widget.p.price.toString();
      _imageUrl = widget.p.imageUrl;
    }
  }

  @override
  void dispose() {
    _vm.disposeConnectivity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.p != null ? 'Update Product' : 'Add Product'),
      ),
      body: Consumer<GeneralProvider>(
        builder: (ctx, vm, ch) => WillPopScope(
          onWillPop: () async {
            showDialog(
              context: context,
              builder: (context) => ConfirmDialog(
                title: 'Cancel',
                content: 'Do you want to cancel ?',
                onCancelTitle: 'No',
                onCancel: () {
                  Navigator.pop(context);
                },
                onConfirmTitle: 'Yes',
                onConfirm: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            );
            return false;
          },
          child: vm.networkState == NetworkState.NO_CONNECTION
              ? NoConnectionView()
              : ModalProgressHUD(
                  inAsyncCall: vm.isLoading,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => ImagePickerDialog(
                                onImageReceived: (String path) {
                                  vm.setImageFilePath(path);
                                },
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100.0,
                                width: 100.0,
                                child: vm.imageFilepath != null
                                    ? Image.file(
                                        File(
                                          vm.imageFilepath,
                                        ),
                                  fit: BoxFit.fill,
                                      )
                                    : Icon(
                                        Icons.add_photo_alternate_outlined,
                                      ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
                          initialValue: widget.p != null ? _title : '',
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'Enter product title',
                          ),
                          onSaved: (String value) {
                            _title = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter properiate title';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
                          initialValue: widget.p != null ? _description : '',
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: 'Enter product description',
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          // textInputAction: TextInputAction.newline,
                          onSaved: (String value) {
                            _description = value;
                          },
                          validator: (String value) {
                            if (value.length < 10) {
                              return 'Please Enter at least 10 digits';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
                          initialValue:
                              widget.p != null ? _price.toString() : '',
                          decoration: InputDecoration(
                            labelText: 'Enter product price',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (String value) {
                            _price = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter correct price';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                widget.p != null
                                    ? 'Update Product'
                                    : 'Add Product',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).accentColor,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  vm.setLoading(true);
                                  _formKey.currentState.save();
                                  String result;
                                  if (widget.p != null) {
                                    result = await vm.updateProduct(
                                      Product(
                                        id: _id,
                                        title: _title,
                                        description: _description,
                                        imageUrl: _imageUrl,
                                        price: double.parse(_price),
                                      ),
                                    );
                                  } else {
                                    result = await vm.addProduct(
                                      Product.withoutId(
                                        title: _title,
                                        description: _description,
                                        imageUrl: vm.imageFilepath,
                                        price: double.parse(_price),
                                      ),
                                    );
                                  }
                                  if (result == Auth.success) {
                                    await vm.clearProductList();
                                    Navigator.pop(context);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => ConfirmDialog(
                                        title: 'Network error',
                                        content:
                                            'There is a problem with your connection',
                                        onConfirm: () {
                                          Navigator.pop(ctx);
                                          Navigator.pop(ctx);
                                        },
                                        onConfirmTitle: 'Okay',
                                      ),
                                    );
                                  }
                                  vm.setLoading(false);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
