import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.logger.dart';
import '../../../../../app/core/custom_base_view_model.dart';

class GantiPasswordDialogViewModel extends CustomBaseViewModel {
  final log = getLogger('GantiPasswordDialogViewModel');

  // form variable
  final globalKey = GlobalKey<FormState>();
  TextEditingController passwordLamaController = TextEditingController();
  TextEditingController passwordBaruController = TextEditingController();
  TextEditingController konfirmasiPasswordBaruController =
      TextEditingController();

  TextEditingController thePasswordLamaController = TextEditingController();

  bool isPasswordLamaObscure = true;
  bool isPasswordBaruObscure = true;
  bool isKonfirmasiPasswordBaruObscure = true;

  // String? passwordLama;

  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    String? passwordLama = await mySharedPrefs.getString('password');
    thePasswordLamaController.text = passwordLama!;
  }

  Future<bool> gantiPassword() async {
    setBusy(true);

    try {
      String? nik = await mySharedPrefs.getString('nik');
      var formData = FormData.fromMap({
        'nik': nik,
        'password_lama': passwordLamaController.text,
        'password_baru': passwordBaruController.text,
      });
      await httpService.postWithFormData(
          'login/ganti_pass_tim_survei', formData);
      return true;
    } catch (e) {
      log.e(e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }
}
