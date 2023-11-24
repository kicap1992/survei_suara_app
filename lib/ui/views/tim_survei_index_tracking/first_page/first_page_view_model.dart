import '../../../../app/app.dialogs.dart';
import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../model/my_response.model.dart';

class FirstPageViewModel extends CustomBaseViewModel {
  final log = getLogger('FirstPageViewModel');
  int counter = 0;
  String? nik;
  String? nama;
  Future<void> init() async {
    globalVar.backPressed = 'exitApp';
    nik = await mySharedPrefs.getString('nik');
    nama = await mySharedPrefs.getString('nama');
    await getData();
  }

  getData() async {
    setBusy(true);

    try {
      var response = await httpService.get('tim_survei/counter/$nik');
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      counter = myResponseModel.data;
    } catch (e) {
      log.e(e.toString());
    } finally {
      setBusy(false);
    }
  }

  gantiPassword() async {
    var res = await dialogService.showCustomDialog(
      variant: DialogType.gantiPasswordDialogView,
      title: 'Ganti Password',
      mainButtonTitle: 'Simpan',
      barrierDismissible: false,
    );

    if (res!.confirmed) {
      snackbarService.showSnackbar(message: 'Password berhasil diubah');
    }
  }
}
