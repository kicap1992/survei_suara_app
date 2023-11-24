import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../app/themes/app_colors.dart';
import '../../../../../app/themes/app_text.dart';
import '../../../../widgets/my_textformfield.dart';
import './ganti_password_dialog_view_model.dart';

class GantiPasswordDialogView extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const GantiPasswordDialogView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GantiPasswordDialogViewModel>.reactive(
      viewModelBuilder: () => GantiPasswordDialogViewModel(),
      onViewModelReady: (GantiPasswordDialogViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        GantiPasswordDialogViewModel model,
        Widget? child,
      ) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: model.globalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ganti Password',
                    style: boldTextStyle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  MyTextFormField(
                    labelText: 'Password Lama',
                    hintText: 'Masukkan password lama',
                    obscureText: model.isPasswordLamaObscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        model.isPasswordLamaObscure =
                            !model.isPasswordLamaObscure;
                        model.notifyListeners();
                      },
                      icon: Icon(
                        model.isPasswordLamaObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    controller: model.passwordLamaController,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required(
                            'Password lama tidak boleh kosong'),
                        Validatorless.min(
                            8, 'Password lama minimal 8 karakter'),
                        Validatorless.compare(
                          model.thePasswordLamaController,
                          'Password lama tidak sama',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextFormField(
                    labelText: 'Password Baru',
                    hintText: 'Masukkan password baru',
                    obscureText: model.isPasswordBaruObscure,
                    controller: model.passwordBaruController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        model.isPasswordBaruObscure =
                            !model.isPasswordBaruObscure;
                        model.notifyListeners();
                      },
                      icon: Icon(
                        model.isPasswordBaruObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required(
                            'Password baru tidak boleh kosong'),
                        Validatorless.min(
                            8, 'Password baru minimal 8 karakter'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextFormField(
                    labelText: 'Konfirmasi Password Baru',
                    hintText: 'Masukkan konfirmasi password baru',
                    obscureText: model.isKonfirmasiPasswordBaruObscure,
                    controller: model.konfirmasiPasswordBaruController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        model.isKonfirmasiPasswordBaruObscure =
                            !model.isKonfirmasiPasswordBaruObscure;
                        model.notifyListeners();
                      },
                      icon: Icon(
                        model.isKonfirmasiPasswordBaruObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required(
                            'Konfirmasi password baru tidak boleh kosong'),
                        Validatorless.min(
                            8, 'Konfirmasi password baru minimal 8 karakter'),
                        Validatorless.compare(
                          model.passwordBaruController,
                          'Password baru tidak sama',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (model.globalKey.currentState!.validate()) {
                            // remove keyboard
                            FocusScope.of(context).unfocus();

                            model.dialogService
                                .showConfirmationDialog(
                              title: 'Konfirmasi',
                              description:
                                  'Apakah anda yakin ingin mengubah password?',
                              cancelTitle: 'Batal',
                              confirmationTitle: 'Ya',
                            )
                                .then(
                              (response) async {
                                if (response!.confirmed) {
                                  // completer!(DialogResponse(confirmed: true));
                                  // model.log.i('Password berhasil diubah');
                                  bool res = await model.gantiPassword();
                                  // model.log.i('res: $res');
                                  if (res) {
                                    completer!(DialogResponse(confirmed: true));
                                    model.log.i('Password berhasil diubah');
                                  }
                                } else {
                                  model.log.i('Password gagal diubah');
                                }
                              },
                            );
                          }
                        },
                        child: const Text('Simpan'),
                      ),
                      TextButton(
                        onPressed: () =>
                            completer!(DialogResponse(confirmed: false)),
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: dangerColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
