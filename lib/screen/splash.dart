import 'package:flutter/material.dart';
import 'package:mercado/screen/login.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/header_text_5.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  static const String id = 'SPLASH';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    GeneralProvider _vm = Provider.of<GeneralProvider>(context, listen: false);
    _vm.initPreferences();
    _vm.initAuth();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _controller.addListener(() => setState(() {}));
    _controller.forward();
    Future.delayed(Duration(seconds: 2), () {
      _vm.isFirstTime
          ? Navigator.pushReplacementNamed(context, Login.id)
          : Navigator.pushReplacementNamed(context, Home.id);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Opacity(
          opacity: _controller.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/mercado_color.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30.0,
              ),
              Consumer<GeneralProvider>(
                builder: (context, vm, child) => Header5(
                  title: 'Mercado',
                  size: 30.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
