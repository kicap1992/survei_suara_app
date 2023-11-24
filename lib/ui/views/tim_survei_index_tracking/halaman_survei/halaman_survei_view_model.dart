import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';
import '../../../../model/area_model.dart';
import '../../../../model/my_response.model.dart';

class HalamanSurveiViewModel extends CustomBaseViewModel {
  final log = getLogger('HalamanSurveiViewModel');

  // form
  final formKey = GlobalKey<FormState>();
  TextEditingController ktpController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController noTPScontroller = TextEditingController();

  // image picker
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  Uint8List? imageBytes;

  // area
  List<KecamatanModel> listKecamatanModel = [];
  List<String> listKecamatanString = [];
  List<KelurahanModel> listKelurahanModel = [];
  List<String> listKelurahanString = [];
  // List<AreaModel> allListKecamatanModel = [];
  String? selectedKecamatan;
  String? selectedKelurahan;
  // int areaIndex = 0;

  // // caleg
  // List<CalegModel> listCalegModel = [];
  // List<String> listCalegString = [];
  // String? selectedCaleg;

  // ini baru
  String? idCaleg;
  String? nik;

  Future<void> init() async {
    globalVar.backPressed = 'exitApp';

    String idCaleg = await mySharedPrefs.getString('id_caleg') ?? '';
    this.idCaleg = idCaleg;
    nik = await mySharedPrefs.getString('nik') ?? '';
    await getData();
  }

  getData() async {
    log.i('getData');
    setBusy(true);
    globalVar.backPressed = 'cantBack';
    try {
      // this one is before
      // var response = await httpService.get('area');

      // String? nik = await mySharedPrefs.getString('nik');
      var response = await httpService.get('area/cek_area/$nik');
      // log.i(response.data);
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      KecamatanDetail kecamatanDetail =
          KecamatanDetail.fromJson(myResponseModel.data);

      listKecamatanModel = kecamatanDetail.kecamatan!;
      selectedKecamatan = listKecamatanModel[0].name!;
      for (var element in listKecamatanModel) {
        listKecamatanString.add(element.name!);
      }

      // log.i('kecamatanDetail: ${kecamatanDetail.kecamatan}');

      String idKecamatan = listKecamatanModel[0].kecamatanId!;
      await getKelurahan(idKecamatan);

      // AreaListModel areaListModel =
      //     AreaListModel.fromJson(myResponseModel.data);
      // listKecamatanModel = areaListModel.area!;
      // allListKecamatanModel = areaListModel.area!;
      // for (var element in listKecamatanModel) {
      //   listKecamatanString.add(element.namaArea!);
      // }
      // selectedKecamatan = listKecamatanString[0];
      // // int idArea = listKecamatanModel[0].idArea!;
      // await getCaleg(idArea);

      // getCaleg()
    } catch (e) {
      log.e(e);
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  getKelurahan(String idKecamatan) async {
    log.i('getKelurahan');
    listKelurahanModel = [];
    listKelurahanString = [];
    selectedKelurahan = null;
    setBusy(true);
    try {
      var response = await httpService.get('area/kelurahan/$idKecamatan');
      // log.i(response.data);
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      KelurahanDetail kelurahanDetail =
          KelurahanDetail.fromJson(myResponseModel.data);
      // log.i('kelurahanDetail: ${kelurahanDetail.kelurahan}');
      listKelurahanModel = kelurahanDetail.kelurahan!;
      for (var element in listKelurahanModel) {
        listKelurahanString.add(element.name!);
      }
      selectedKelurahan = listKelurahanString[0];
    } catch (e) {
      log.e(e);
    } finally {
      setBusy(false);
    }
  }

  void addImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageFile = image;
        _imagePath = image.path;
        imageBytes = await image.readAsBytes();

        log.i('image path: $_imagePath');
        notifyListeners();
      }
    } catch (e) {
      log.e(e);
    }
  }

  uploadData() async {
    log.i('uploadData');
    setBusy(true);
    easyLoading.customLoading('Uploading data...');
    globalVar.backPressed = 'cantBack';
    try {
      String idKecamatan =
          listKecamatanModel[listKecamatanString.indexOf(selectedKecamatan!)]
              .kecamatanId
              .toString();
      String idKelurahan =
          listKelurahanModel[listKelurahanString.indexOf(selectedKelurahan!)]
              .kelurahanId
              .toString();
      var fomData = FormData.fromMap(
        {
          'ktp': ktpController.text,
          'nama': namaController.text,
          'idCaleg': idCaleg,
          'foto': await MultipartFile.fromFile(
            _imagePath!,
            filename: imageFile!.name,
            contentType: MediaType('image', 'jpg'),
          ),
          'idKecamatan': idKecamatan,
          'idKelurahan': idKelurahan,
          'nik': nik,
          'noTPS': noTPScontroller.text,
        },
      );
      await httpService.postWithFormData('tim_survei', fomData);
      snackbarService.showSnackbar(
        message: 'Data berhasil diupload',
        title: 'Berhasil',
        duration: const Duration(milliseconds: 2500),
      );
      // clear data
      ktpController.clear();
      namaController.clear();
      _imagePath = null;
      imageFile = null;
      imageBytes = null;
      noTPScontroller.clear();
      notifyListeners();
    } catch (e) {
      log.e(e);
    } finally {
      easyLoading.dismissLoading();
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }
}
