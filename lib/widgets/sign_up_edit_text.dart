import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mercado/constants.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/edit_text.dart';
import 'package:provider/provider.dart';

class SignUpEditText extends StatefulWidget {
  final bool isLogin;
  final Function facebookPressed;
  final Function googlePressed;

  SignUpEditText({
    @required this.isLogin,
    @required this.facebookPressed,
    @required this.googlePressed,
  });

  @override
  _SignUpEditTextState createState() => _SignUpEditTextState();
}

class _SignUpEditTextState extends State<SignUpEditText> {
  bool _loginEmailIsFocus = false,
      _loginPasswordIsFocus = false,
      _signUpPasswordIsFocus = false,
      _signUpConfirmPasswordIsFocus = false,
      _signUpFullNameIsFocus = false,
      _signUpEmailIsFocus = false;
  GeneralProvider _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<GeneralProvider>(context, listen: false);
    _viewModel.initControllersAndFocus();
    _viewModel.loginEmailNode.addListener(() => setState(
        () => _loginEmailIsFocus = _viewModel.loginEmailNode.hasFocus));
    _viewModel.loginPasswordNode.addListener(() => setState(
        () => _loginPasswordIsFocus = _viewModel.loginPasswordNode.hasFocus));
    _viewModel.signUpEmailNode.addListener(() => setState(
        () => _signUpEmailIsFocus = _viewModel.signUpEmailNode.hasFocus));
    _viewModel.signUpFullNameNode.addListener(() => setState(
        () => _signUpFullNameIsFocus = _viewModel.signUpFullNameNode.hasFocus));
    _viewModel.signUpPasswordNode.addListener(() => setState(
        () => _signUpPasswordIsFocus = _viewModel.signUpPasswordNode.hasFocus));
    _viewModel.signUpConfirmPasswordNode.addListener(() => setState(() =>
        _signUpConfirmPasswordIsFocus =
            _viewModel.signUpConfirmPasswordNode.hasFocus));
    _viewModel.loginEmailController.addListener(() => setState(() =>
        EmailValidator.validate(_viewModel.loginEmailController.text)
            ? _viewModel.setLoginEmailErrorMsg(null)
            : _viewModel.setLoginEmailErrorMsg(emailErrorMsg)));
    _viewModel.loginPasswordController.addListener(() => setState(() =>
        _viewModel.loginPasswordController.text.length < 6
            ? _viewModel.setLoginPasswordErrorMsg(passwordErrorMsg)
            : _viewModel.setLoginPasswordErrorMsg(null)));

    _viewModel.signUpEmailController.addListener(() => setState(() =>
        EmailValidator.validate(_viewModel.signUpEmailController.text)
            ? _viewModel.setSignUpEmailErrorMsg(null)
            : _viewModel.setSignUpEmailErrorMsg(emailErrorMsg)));

    _viewModel.signUpFullNameController.addListener(() => setState(() =>
        _viewModel.signUpFullNameController.text.length < 5
            ? _viewModel.setSignUpFullNameErrorMsg(fullNameErrorMsg)
            : _viewModel.setSignUpFullNameErrorMsg(null)));

    _viewModel.signUpPasswordController.addListener(() => setState(() =>
    _viewModel.signUpPasswordController.text.length < 6
        ? _viewModel.setSignUpPasswordErrorMsg(passwordErrorMsg)
        : _viewModel.setSignUpPasswordErrorMsg(null)));

    _viewModel.signUpConfirmPasswordController.addListener(() => setState(() =>
    _viewModel.signUpConfirmPasswordController.text.length < 6
        ? _viewModel.setSignUpConfirmPasswordErrorMsg(passwordErrorMsg)
        : _viewModel.setSignUpConfirmPasswordErrorMsg(null)));

  }

  @override
  void dispose() {
    _viewModel.disposeControllerAndFocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Consumer<GeneralProvider>(
        builder: (context, vm, child) => widget.isLogin
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditText(
                    focusNode: vm.loginEmailNode,
                    controller: vm.loginEmailController,
                    labelText: 'Email address',
                    isPassword: false,
                    isFocused: _loginEmailIsFocus,
                    errorMsg: vm.loginEmailErrorMsg,
                    capitalization: TextCapitalization.sentences,
                    type: TextInputType.emailAddress,
                  ),
                  EditText(
                    focusNode: vm.loginPasswordNode,
                    controller: vm.loginPasswordController,
                    labelText: 'Password',
                    isPassword: true,
                    isFocused: _loginPasswordIsFocus,
                    errorMsg: vm.loginPasswordErrorMsg,
                    type: TextInputType.visiblePassword,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.facebookPressed,
                        icon: Icon(
                          FontAwesome.facebook,
                          // color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.googlePressed,
                        icon: Icon(
                          FontAwesome.google_plus,
                          // color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditText(
                    focusNode: vm.signUpFullNameNode,
                    controller: vm.signUpFullNameController,
                    labelText: 'Full name',
                    isPassword: false,
                    isFocused: _signUpFullNameIsFocus,
                    errorMsg: vm.signUpFullNameErrorMsg,
                    capitalization: TextCapitalization.words,
                    type: TextInputType.text,
                  ),
                  EditText(
                    focusNode: vm.signUpEmailNode,
                    controller: vm.signUpEmailController,
                    labelText: 'Email address',
                    isPassword: false,
                    isFocused: _signUpEmailIsFocus,
                    errorMsg: vm.signUpEmailErrorMsg,
                    capitalization: TextCapitalization.sentences,
                    type: TextInputType.emailAddress,
                  ),
                  EditText(
                    focusNode: vm.signUpPasswordNode,
                    controller: vm.signUpPasswordController,
                    labelText: 'Password',
                    isPassword: true,
                    isFocused: _signUpPasswordIsFocus,
                    errorMsg: vm.signUpPasswordErrorMsg,
                    type: TextInputType.visiblePassword,
                  ),
                  EditText(
                    focusNode: vm.signUpConfirmPasswordNode,
                    controller: vm.signUpConfirmPasswordController,
                    labelText: 'Password again',
                    isPassword: true,
                    isFocused: _signUpConfirmPasswordIsFocus,
                    errorMsg: vm.signUpConfirmPasswordErrorMsg,
                    type: TextInputType.visiblePassword,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.facebookPressed,
                        icon: Icon(
                          FontAwesome.facebook,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.googlePressed,
                        icon: Icon(
                          FontAwesome.google_plus,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
