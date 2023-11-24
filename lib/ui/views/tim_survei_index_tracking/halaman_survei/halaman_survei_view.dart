import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_textformfield.dart';
import './halaman_survei_view_model.dart';

class HalamanSurveiView extends StatelessWidget {
  const HalamanSurveiView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HalamanSurveiViewModel>.reactive(
      viewModelBuilder: () => HalamanSurveiViewModel(),
      onViewModelReady: (HalamanSurveiViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HalamanSurveiViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              // model.log.i('backPressed: ${model.globalVar.backPressed}');
              if (model.globalVar.backPressed == 'exitApp') {
                // model.back();
                model.quitApp(context);
              }
              return false;
            },
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(child: Text('Foto KTP / Wajah Pemilih')),
                        // create a rectangle container that later use to show image with child is KTP icon
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: model.imageBytes != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          model.imageBytes!,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.credit_card_rounded,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: sixthGrey,
                                  child: IconButton(
                                      onPressed: () {
                                        model.addImage();
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: backgroundColor3,
                                        size: 15,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        MyTextFormField(
                          hintText: 'Masukkan KTP / No HP Pemilih',
                          labelText: 'KTP / No HP Pemilih',
                          maxLength: 16,
                          suffixIcon: const Icon(Icons.add_card_rounded),
                          controller: model.ktpController,
                          keyboardType: TextInputType.number,
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required(
                                  'KTP / No HP Pemilih tidak boleh kosong'),
                              Validatorless.number(
                                  'KTP / No HP Pemilih harus angka'),
                              Validatorless.min(
                                  10, 'KTP / No HP Pemilih minimal 10 digit'),
                              Validatorless.max(
                                  16, 'KTP / No HP Pemilih maksimal 16 digit'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        MyTextFormField(
                          hintText: 'Masukkan Nama Pemilih',
                          labelText: 'Nama Pemilih',
                          suffixIcon: const Icon(Icons.person),
                          controller: model.namaController,
                          validator: Validatorless.required(
                              'Nama Pemilih tidak boleh kosong'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '  Pilih Kecamatan',
                        ),
                        if (model.isBusy)
                          const Center(child: CircularProgressIndicator()),
                        if (!model.isBusy && model.selectedKecamatan != null)
                          Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: sixthGrey,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: model.selectedKecamatan!,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    model.log.i(newValue);
                                    model.selectedKecamatan = newValue!;
                                    String kecamatanId = model
                                        .listKecamatanModel[model
                                            .listKecamatanString
                                            .indexOf(newValue)]
                                        .kecamatanId!;
                                    model.getKelurahan(kecamatanId);
                                    // model.changeArea(newValue);
                                    model.notifyListeners();
                                  },
                                  items: model.listKecamatanString
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          overflow: TextOverflow.ellipsis),
                                    );
                                  }).toList()),
                            ),
                          ),

                        const SizedBox(height: 20),
                        const Text(
                          '  Pilih Kelurahan / Desa',
                        ),
                        if (model.isBusy)
                          const Center(child: CircularProgressIndicator()),
                        if (!model.isBusy && model.selectedKelurahan != null)
                          Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: sixthGrey,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: model.selectedKelurahan!,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    model.log.i(newValue);
                                    model.selectedKelurahan = newValue!;
                                    // model.changeArea(newValue);
                                    model.notifyListeners();
                                  },
                                  items: model.listKelurahanString
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          overflow: TextOverflow.ellipsis),
                                    );
                                  }).toList()),
                            ),
                          ),

                        const SizedBox(height: 20),
                        MyTextFormField(
                          hintText: 'Masukkan No TPS',
                          labelText: 'Nomor TPS',
                          maxLength: 2,
                          suffixIcon: const Icon(Icons.account_balance),
                          controller: model.noTPScontroller,
                          keyboardType: TextInputType.number,
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required(
                                  'Nomor TPS tidak boleh kosong'),
                              Validatorless.number('Nomor TPS harus angka'),
                              Validatorless.min(1, 'Nomor TPS minimal 1 digit'),
                              Validatorless.max(
                                  2, 'Nomor TPS maksimal 2 digit'),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 20),
                        // const Text(
                        //   '  Pilih Caleg',
                        // ),
                        // if (model.isBusy)
                        //   const Center(child: CircularProgressIndicator()),
                        // if (!model.isBusy)
                        //   Container(
                        //     width: double.infinity,
                        //     height: 60,
                        //     padding: const EdgeInsets.symmetric(horizontal: 10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(25),
                        //       border: Border.all(
                        //         color: sixthGrey,
                        //       ),
                        //     ),
                        //     child: Expanded(
                        //       child: DropdownButtonHideUnderline(
                        //         child: DropdownButton<String>(
                        //             isExpanded: true,
                        //             value: model.selectedCaleg!,
                        //             icon: const Icon(Icons.arrow_drop_down),
                        //             iconSize: 24,
                        //             elevation: 16,
                        //             style: const TextStyle(color: Colors.black),
                        //             onChanged: (String? newValue) {
                        //               model.log.i(newValue);
                        //               model.selectedCaleg = newValue!;

                        //               model.notifyListeners();
                        //             },
                        //             items: model.listCalegString
                        //                 .map<DropdownMenuItem<String>>(
                        //                     (String value) {
                        //               return DropdownMenuItem<String>(
                        //                 value: value,
                        //                 child: Text(value,
                        //                     overflow: TextOverflow.ellipsis),
                        //               );
                        //             }).toList()),
                        //       ),
                        //     ),
                        //   ),

                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 200,
                            child: MyButton(
                              text: 'Upload Data',
                              onPressed: () {
                                if (model.imageBytes == null) {
                                  model.snackbarService.showSnackbar(
                                    message:
                                        'Foto KTP / Wajah Pemilih tidak boleh kosong',
                                  );
                                  model.addImage();
                                  return;
                                }

                                if (model.formKey.currentState!.validate()) {
                                  // hide keyboard
                                  FocusScope.of(context).unfocus();
                                  model.dialogService
                                      .showDialog(
                                    title: 'Upload Data',
                                    description:
                                        'Apakah anda yakin ingin mengupload data?',
                                    buttonTitle: 'Ya',
                                    cancelTitle: 'Tidak',
                                  )
                                      .then((value) async {
                                    if (value!.confirmed) {
                                      await model.uploadData();
                                    }
                                  });
                                  // model.uploadData();
                                }
                              },
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
      },
    );
  }
}
