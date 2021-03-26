import 'package:flutter/material.dart';
import 'package:mercado/view_model/general_provider.dart';
import 'package:mercado/widgets/header_text_5.dart';
import 'package:mercado/widgets/logout_button.dart';
import 'package:mercado/widgets/profile_image.dart';
import 'package:mercado/widgets/update_password_button.dart';
import 'package:mercado/widgets/username_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const String id = 'PROFILE';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<GeneralProvider>(
      builder: (context, vm, child) =>
        Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: vm.isLoading,
            child: Card(
              elevation: 6.0,
              margin: const EdgeInsets.all(
                12.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileImage(),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    UsernameWidget(),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    vm.getEmail != null
                        ? Header5(
                            title: vm.getEmail,
                    )
                        : Container(),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    UpdatePasswordButton(),
                    LogoutButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
