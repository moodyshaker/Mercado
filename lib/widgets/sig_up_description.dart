import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:provider/provider.dart';

import 'header_text_3.dart';
import 'header_text_5.dart';

class SignUpDescription extends StatelessWidget {
  final bool isLogin;

  SignUpDescription({
    @required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: isLogin
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Header3(
                        title: 'Welcome Back,',
                        size: 37.0,
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Row(
                      children: [
                        Header3(
                          title: 'Hello',
                          size: 37.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Header5(
                          title: 'Beautiful,',
                          size: 40.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Enter your information below or login with a social account',
                    style: Theme.of(context)
                        .appBarTheme
                        .textTheme
                        .headline3
                        .copyWith(
                          color: vm.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 18.0,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
