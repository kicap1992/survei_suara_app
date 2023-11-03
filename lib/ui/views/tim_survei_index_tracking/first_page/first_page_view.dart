import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import '../../../widgets/top_container.dart';
import './first_page_view_model.dart';

class FirstPageView extends StatelessWidget {
  const FirstPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FirstPageViewModel>.reactive(
      viewModelBuilder: () => FirstPageViewModel(),
      onViewModelReady: (FirstPageViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        FirstPageViewModel model,
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopContainer(
                      title: 'Jumlah Pemilih',
                      value: '${model.counter} Orang',
                      icon: Icons.people_alt_outlined,
                      background: blueColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Selamat Datang, ',
                        style: regularTextStyle,
                        children: [
                          TextSpan(
                            text: '${model.nama}\n\n',
                            style: boldTextStyle,
                          ),
                          const TextSpan(
                            text: 'Silahkan tambahkan data ',
                            style: regularTextStyle,
                          ),
                          TextSpan(
                            text: 'Pemilih ',
                            style: boldTextStyle.copyWith(
                              color: greenColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const TextSpan(
                            text: 'dengan menekan menu ',
                            style: regularTextStyle,
                          ),
                          TextSpan(
                            text: 'Survei ',
                            style: boldTextStyle.copyWith(
                              color: greenColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const TextSpan(
                            text: 'di bawah sebelah kanan.\n\n',
                            style: regularTextStyle,
                          ),
                          const TextSpan(
                            text: 'Menu ',
                            style: regularTextStyle,
                          ),
                          TextSpan(
                            text: 'History ',
                            style: boldTextStyle.copyWith(
                              color: greenColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const TextSpan(
                            text:
                                'pada bawah tengah digunakan untuk melihat data yang sudah diinputkan.\n\n',
                            style: regularTextStyle,
                          ),
                          const TextSpan(
                            text: 'Menu ',
                            style: regularTextStyle,
                          ),
                          TextSpan(
                            text: 'Pengaturan ',
                            style: boldTextStyle.copyWith(
                              color: greenColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const TextSpan(
                            text:
                                'pada bawah debelah kanan digunakan untuk mengubah data diri anda.\n\nSekian dari Developer',
                            style: regularTextStyle,
                          ),
                          TextSpan(
                            text: '\nKicap Karan ',
                            style: boldTextStyle.copyWith(
                              color: dangerColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
