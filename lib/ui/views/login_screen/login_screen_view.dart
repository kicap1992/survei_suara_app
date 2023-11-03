import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:validatorless/validatorless.dart';

import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_text.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textformfield.dart';
import './login_screen_view_model.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      onViewModelReady: (LoginScreenViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        LoginScreenViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: warningColor,
          body: WillPopScope(
            onWillPop: () async {
              model.log.i('backPressed: ${model.globalVar.backPressed}');
              if (model.globalVar.backPressed == 'backNormal') {
                // model.back();
                model.quitApp(context);
              }
              return false;
            },
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Halaman Login',
                        ),
                        const Text(
                          '(Survei App)',
                          style: italicTextStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                          controller: model.usernameController,
                          labelText: 'Username',
                          hintText: 'Masukkan Username',
                          suffixIcon: const Icon(Icons.person),
                          validator: Validatorless.required(
                              'Username tidak boleh kosong'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFormField(
                          controller: model.passwordController,
                          hintText: 'Masukkan Password',
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            child: model.isPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onTap: () {
                              model.isPasswordVisible =
                                  !model.isPasswordVisible;
                              model.log.i(
                                  'isPasswordVisible: ${model.isPasswordVisible}');
                              model.notifyListeners();
                            },
                          ),
                          obscureText: !model.isPasswordVisible,
                          validator: Validatorless.required(
                              'Password tidak boleh kosong'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250,
                          child: MyButton(
                            // theBackgroundColor: lightColor,
                            textColor: fontColor,
                            text: 'Login',
                            onPressed: () {
                              if (model.formKey.currentState!.validate()) {
                                model.login();
                              }
                            },
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
      },
    );
  }
}
