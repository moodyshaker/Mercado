import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mercado/constants.dart';
import 'package:mercado/screen/home.dart';
import 'package:mercado/services/auth.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/image_picker_dialog.dart';
import 'package:mercado/widgets/no_connection_view.dart';
import 'package:mercado/widgets/sig_up_description.dart';
import 'package:mercado/widgets/sign_in_appbar.dart';
import 'package:mercado/widgets/sign_in_dialog.dart';
import 'package:mercado/widgets/sign_up_bottom.dart';
import 'package:mercado/widgets/sign_up_edit_text.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String id = 'LOGIN';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GeneralProvider _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.initConnectivity();
  }

  @override
  void dispose() {
    _vm.disposeConnectivity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<GeneralProvider>(
          builder: (context, vm, child) => vm.networkState ==
                  NetworkState.NO_CONNECTION
              ? NoConnectionView()
              : Center(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInAppbar(
                                imageUrl: vm.imageFilepath,
                                titles: <String>['Login', 'Register'],
                                onImagePressed: () {
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
                                onItemPressed: (int i) {
                                  vm.changeSelectedSignUpIndex(i);
                                },
                                selectedItem: vm.selectedSignUpIndex,
                              ),
                              SignUpDescription(
                                  isLogin: vm.selectedSignUpIndex == 0),
                              SignUpEditText(
                                isLogin: vm.selectedSignUpIndex == 0,
                                facebookPressed: () async {
                                  vm.setLoading(true);
                                  String result = await vm.facebookAuth();
                                  if (result == Auth.success) {
                                    String res = await vm.saveAccount(vm.user);
                                    if (res == Auth.success) {
                                      Navigator.pushReplacementNamed(
                                          context, Home.id);
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: result);
                                  }
                                  vm.setLoading(false);
                                },
                                googlePressed: () async {
                                  vm.setLoading(true);
                                  String result = await vm.googleAuth();
                                  if (result == Auth.success) {
                                    String res = await vm.saveAccount(vm.user);
                                    if (res == Auth.success) {
                                      Navigator.pushReplacementNamed(
                                          context, Home.id);
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: result);
                                  }
                                  vm.setLoading(false);
                                },
                              ),
                              SignUpBottom(
                                isLogin: vm.selectedSignUpIndex == 0,
                                onForgetPasswordPressed: () async {
                                  if (vm.selectedSignUpIndex == 0) {
                                    if (vm
                                        .loginEmailController.text.isNotEmpty) {
                                      await vm.accountState(
                                          vm.loginEmailController.text);
                                      if (vm.state == AccountState.REGISTER) {
                                        String result = await vm.forgetPassword(
                                            vm.loginEmailController.text);
                                        if (result == Auth.success) {
                                          Fluttertoast.showToast(
                                              msg: 'Email sent successfully');
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Email not register in our database');
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Please check your email address');
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                          Positioned(
                            right: 20.0,
                            bottom:
                                35.0 - MediaQuery.of(context).viewInsets.bottom,
                            child: GestureDetector(
                              onTap: () async {
                                vm.setLoading(true);
                                if (vm.selectedSignUpIndex == 0) {
                                  if (!EmailValidator.validate(
                                      vm.loginEmailController.text)) {
                                    vm.setLoginEmailErrorMsg(emailErrorMsg);
                                  } else if (vm
                                          .loginPasswordController.text.length <
                                      6) {
                                    vm.setLoginPasswordErrorMsg(
                                        passwordErrorMsg);
                                  } else {
                                    await vm.accountState(
                                        vm.loginEmailController.text);
                                    if (vm.state == AccountState.NOT_FOUND) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => SignInDialog(
                                            vm: vm,
                                            title: 'Login',
                                            content:
                                                'There is no account register in our database do you want to register ?',
                                            leftAction: 'No',
                                            rightAction: 'Register',
                                            rightActionOnPress: () {
                                              vm.changeSelectedSignUpIndex(1);
                                              if (vm.signUpEmailController.text
                                                  .isNotEmpty) {
                                                vm.signUpEmailController
                                                    .clear();
                                              }
                                              vm.signUpEmailController.text =
                                                  vm.loginEmailController.text;
                                              Navigator.pop(context);
                                            },
                                            leftActionOnPress: () {
                                              Navigator.pop(context);
                                            }),
                                      );
                                    } else {
                                      String r = await vm.loginAccount(
                                          vm.loginEmailController.text,
                                          vm.loginPasswordController.text);
                                      if (r == Auth.success) {
                                        String res =
                                            await vm.saveAccount(vm.user);
                                        if (res == Auth.success) {
                                          vm.loginEmailController.clear();
                                          vm.loginPasswordController.clear();
                                          Navigator.pushReplacementNamed(
                                              context, Home.id);
                                        }
                                      } else {
                                        Fluttertoast.showToast(msg: r);
                                      }
                                    }
                                  }
                                } else {
                                  if (!EmailValidator.validate(
                                      vm.signUpEmailController.text)) {
                                    vm.setSignUpEmailErrorMsg(emailErrorMsg);
                                  } else if (vm.signUpPasswordController.text
                                          .length <
                                      6) {
                                    vm.setSignUpPasswordErrorMsg(
                                        passwordErrorMsg);
                                  } else if (vm.signUpConfirmPasswordController
                                          .text.length <
                                      6) {
                                    vm.setSignUpConfirmPasswordErrorMsg(
                                        passwordErrorMsg);
                                  } else if (vm.signUpConfirmPasswordController
                                          .text !=
                                      vm.signUpPasswordController.text) {
                                    vm.setSignUpConfirmPasswordErrorMsg(
                                        passwordNotMatchErrorMsg);
                                  } else if (vm.signUpFullNameController.text
                                          .length <
                                      5) {
                                    vm.setSignUpFullNameErrorMsg(
                                        fullNameErrorMsg);
                                  } else {
                                    await vm.accountState(
                                        vm.signUpEmailController.text);
                                    if (vm.state == AccountState.REGISTER) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => SignInDialog(
                                            vm: vm,
                                            title: 'Register',
                                            content:
                                                'You already registered do you want to login ?',
                                            leftAction: 'No',
                                            rightAction: 'Login',
                                            rightActionOnPress: () {
                                              vm.changeSelectedSignUpIndex(0);
                                              if (vm.loginEmailController.text
                                                  .isNotEmpty) {
                                                vm.loginEmailController.clear();
                                              }
                                              vm.loginEmailController.text =
                                                  vm.signUpEmailController.text;
                                              Navigator.pop(context);
                                            },
                                            leftActionOnPress: () {
                                              Navigator.pop(context);
                                            }),
                                      );
                                    } else {
                                      vm.setLoading(true);
                                      String r = await vm.createAccount(
                                          vm.signUpEmailController.text,
                                          vm.signUpPasswordController.text,
                                          username:
                                              vm.signUpFullNameController.text,
                                          photoUrl: vm.imageFilepath);
                                      if (r == Auth.success) {
                                        String res =
                                            await vm.saveAccount(vm.user);
                                        if (res == Auth.success) {
                                          vm.signUpEmailController.clear();
                                          vm.signUpPasswordController.clear();
                                          vm.signUpConfirmPasswordController
                                              .clear();
                                          vm.signUpFullNameController.clear();
                                          vm.setImageFilePath(null);
                                          Navigator.pushReplacementNamed(
                                              context, Home.id);
                                        } else {
                                          Fluttertoast.showToast(msg: r);
                                        }
                                      }
                                    }
                                  }
                                }
                                vm.setLoading(false);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: vm.isLoading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : Icon(
                                        Icons.arrow_right_alt,
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
