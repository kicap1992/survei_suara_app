import 'package:cek_suara_app/model/my_response.model.dart';
import 'package:cek_suara_app/model/pemilih_model.dart';

import '../../../../app/app.bottomsheets.dart';
import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';

class HalamanHistoryViewModel extends CustomBaseViewModel {
  final log = getLogger('HalamanHistoryViewModel');
  int counter = 0;
  List<PemilihModel> listPemilih = [];
  bool status = false;

  String namaCaleg = '...';
  Future<void> init() async {
    await getData();
  }

  getData() async {
    setBusy(true);

    try {
      String? nik = await mySharedPrefs.getString('nik');
      var response = await httpService.get('tim_survei/$nik');
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      PemilihDetailModel pemilihDetailModel =
          PemilihDetailModel.fromJson(myResponseModel.data);
      listPemilih = pemilihDetailModel.pemilihModel!;
      log.i('listPemilih: $listPemilih');
      namaCaleg = listPemilih[0].namaCaleg!;
      counter = pemilihDetailModel.jumlah!;
      log.i('counter: $counter');
      status = true;
    } catch (e) {
      log.e(e.toString());
      status = false;
    } finally {
      setBusy(false);
    }
  }

  showDetailPemilih(PemilihModel listPemilih) async {
    await bottomSheetService.showCustomSheet(
      variant: BottomSheetType.detailSuaraPemilihBottomSheetView,
      title: 'Detail Suara Pemilih',
      description: 'Detail Suara Pemilih',
      // isScrollControlled: true,
      data: listPemilih,
    );
  }
}
