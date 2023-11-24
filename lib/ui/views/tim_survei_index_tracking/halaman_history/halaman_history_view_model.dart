import '../../../../app/app.bottomsheets.dart';
import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../model/my_response.model.dart';
import '../../../../model/pemilih_model.dart';

class HalamanHistoryViewModel extends CustomBaseViewModel {
  final log = getLogger('HalamanHistoryViewModel');
  int counter = 0;
  List<PemilihModel> listPemilih = [];
  bool status = false;

  String namaCaleg = '...';
  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    await getData();
  }

  getData() async {
    setBusy(true);

    try {
      String? nik = await mySharedPrefs.getString('nik');
      var response = await httpService.get('tim_survei/$nik');
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      PemilihDetail pemilihDetail =
          PemilihDetail.fromJson(myResponseModel.data);
      listPemilih = pemilihDetail.pemilihModel ?? [];
      // log.i('listPemilih: $listPemilih');
      counter = pemilihDetail.jumlah!;
      namaCaleg = counter > 0 ? listPemilih[0].namaCaleg! : '...';
      // log.i('counter: $counter');
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
