import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import './halaman_history_view_model.dart';

class HalamanHistoryView extends StatelessWidget {
  const HalamanHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HalamanHistoryViewModel>.reactive(
      viewModelBuilder: () => HalamanHistoryViewModel(),
      onViewModelReady: (HalamanHistoryViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HalamanHistoryViewModel model,
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
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: warningColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Caleg : ",
                            style: italicTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              model.namaCaleg,
                              style: boldTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        alignment: model.isBusy
                            ? Alignment.center
                            : model.status == true
                                ? model.counter > 0
                                    ? Alignment.topCenter
                                    : Alignment.center
                                : Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: warningColor,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              if (model.isBusy)
                                const Center(
                                    child: CircularProgressIndicator()),
                              if (!model.isBusy &&
                                  model.status == true &&
                                  model.counter > 0)
                                for (var i = 0; i < model.counter; i++)
                                  Card(
                                    child: ListTile(
                                      // leading is datetime dummy
                                      leading:
                                          Text(model.listPemilih[i].createdAt!),
                                      title: Text(
                                        model.listPemilih[i].namaPemilih!,
                                        style: boldTextStyle,
                                      ),
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CardWidget(
                                              title: 'Kec',
                                              value: model
                                                  .listPemilih[i].kecamatan!),
                                          CardWidget(
                                              title: 'Kel / Desa',
                                              value: model
                                                  .listPemilih[i].kelurahan!),
                                          CardWidget(
                                              title: 'TPS',
                                              value: model.listPemilih[i].tps!
                                                  .toString()),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.info_outline,
                                          color: mainColor,
                                        ),
                                        onPressed: () {
                                          model.showDetailPemilih(
                                            model.listPemilih[i],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                              if (!model.isBusy &&
                                  model.status == true &&
                                  model.counter == 0)
                                const Center(
                                  child: Text(
                                    'Belum ada data',
                                    style: boldTextStyle,
                                  ),
                                ),
                              if (!model.isBusy && model.status == false)
                                const Center(
                                  child: Text(
                                    'Error: Gagal mengambil data dari server',
                                    style: boldTextStyle,
                                  ),
                                ),
                            ],
                          ),
                        ),
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

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: italicTextStyle.copyWith(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(
            ' : ',
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: boldTextStyle.copyWith(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
