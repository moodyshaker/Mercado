import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'header_text_5.dart';

class SignUpBottom extends StatelessWidget {
  final bool isLogin;
  final Function onForgetPasswordPressed;

  SignUpBottom({
    @required this.isLogin,
    @required this.onForgetPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLogin)
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: GestureDetector(
                onTap: onForgetPasswordPressed,
                child: Header5(
                  title: 'Forget password ?',
                  size: 17.0,
                ),
              ),
            ),
          if (isLogin)
            const SizedBox(
              height: 10.0,
            ),
          Container(
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                )),
          )
        ],
      ),
    );
  }
}
