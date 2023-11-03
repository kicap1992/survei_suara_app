import 'package:cek_suara_app/ui/views/tim_survei_index_tracking/first_page/first_page_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './halaman_pengaturan_view_model.dart';

class HalamanPengaturanView extends StatelessWidget {
  const HalamanPengaturanView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HalamanPengaturanViewModel>.reactive(
      viewModelBuilder: () => HalamanPengaturanViewModel(),
      onViewModelReady: (HalamanPengaturanViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HalamanPengaturanViewModel model,
        Widget? child,
      ) {
        return WillPopScope(
          onWillPop: () async {
            // model.log.i('backPressed: ${model.globalVar.backPressed}');
            if (model.globalVar.backPressed == 'exitApp') {
              // model.back();
              model.quitApp(context);
            }
            return false;
          },
          child: const FirstPageView(),
        );
      },
    );
  }
}
