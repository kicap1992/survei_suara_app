import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../app/app.router.dart';
import '../../../app/app.logger.dart';
import '../../../app/core/custom_base_view_model.dart';
import '../../../model/my_response.model.dart';
import '../../../model/tim_survei_model.dart';

class LoginScreenViewModel extends CustomBaseViewModel {
  final log = getLogger('LoginScreenViewModel');

  // variable
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  Future<void> init() async {
    globalVar.backPressed = 'backNormal';
  }

  login() async {
    easyLoading.customLoading('Login..');
    globalVar.backPressed = 'cantBack';

    try {
      var formData = FormData.fromMap({
        'username': usernameController.text,
        'password': passwordController.text,
      });
      var response =
          await httpService.postWithFormData('login/tim_survei', formData);

      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      var data = myResponseModel.data;
      TimSurveiModel timSurveiModel = TimSurveiModel.fromJson(data);

      mySharedPrefs.setString('nik', timSurveiModel.nik!);
      mySharedPrefs.setString('nama', timSurveiModel.nama!);
      mySharedPrefs.setString('id_caleg', timSurveiModel.idCaleg.toString());
      mySharedPrefs.setString('level', 'tim_survei');
      mySharedPrefs.setString('password', passwordController.text);
      snackbarService.showSnackbar(
        message: 'Selamat datang kembali ${timSurveiModel.nama}',
        title: 'Login Berhasil',
        duration: const Duration(milliseconds: 2500),
      );
      navigationService.navigateToTimSurveiIndexTrackingView();
    } catch (e) {
      log.e('error: $e');
    } finally {
      easyLoading.dismissLoading();
      globalVar.backPressed = 'backNormal';
    }

    // navigationService.pushNamedAndRemoveUntil('/home-screen');
    // await navigationService.navigateToAdminIndexTrackingView();
  }
}
