import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/app.bottomsheets.dart';
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

  // image picker
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  Uint8List? imageBytes;

  // area
  List<AreaModel> listAreaModel = [];
  List<String> listAreaString = [];
  List<AreaModel> allListAreaModel = [];
  String? selectedArea;
  int areaIndex = 0;

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
      log.i(response.data);
      MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
      AreaListModel areaListModel =
          AreaListModel.fromJson(myResponseModel.data);
      listAreaModel = areaListModel.area!;
      allListAreaModel = areaListModel.area!;
      for (var element in listAreaModel) {
        listAreaString.add(element.namaArea!);
      }
      selectedArea = listAreaString[0];
      // int idArea = listAreaModel[0].idArea!;
      // await getCaleg(idArea);

      // getCaleg()
    } catch (e) {
      log.e(e);
    } finally {
      globalVar.backPressed = 'exitApp';
      setBusy(false);
    }
  }

  // getCaleg(int idArea) async {
  //   log.i('getCaleg');
  //   log.i('idArea: $idArea');
  //   selectedCaleg = null;
  //   listCalegModel = [];
  //   listCalegString = [];
  //   setBusy(true);
  //   try {
  //     var response = await httpService.get('caleg/area/$idArea');
  //     log.i(response.data);
  //     MyResponseModel myResponseModel = MyResponseModel.fromJson(response.data);
  //     // log.i(myResponseModel.data);
  //     CalegListModel calegListModel =
  //         CalegListModel.fromJson(myResponseModel.data);
  //     listCalegModel = calegListModel.caleg!;
  //     for (var element in listCalegModel) {
  //       listCalegString.add(element.namaCaleg!);
  //     }
  //     selectedCaleg = listCalegString[0];
  //     // log.i('listCalegModel: $listCalegModel');
  //     // log.i('listCalegString: $listCalegString');
  //     // log.i('selectedCaleg: $selectedCaleg');
  //   } catch (e) {
  //     log.e(e);
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  // changeArea(String? value) async {
  //   int idArea = listAreaModel[listAreaString.indexOf(value!)].idArea!;
  //   // log.i('idArea: $idArea');
  //   await getCaleg(idArea);
  // }

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

  searchArea() async {
    var res = await bottomSheetService.showCustomSheet(
      variant: BottomSheetType.bottomSheetCariAreaView,
      ignoreSafeArea: false,
      isScrollControlled: true,
    );

    if (res!.confirmed) {
      log.i('res.data: ${res.data}');

      String area = res.data;
      if (area == '') {
        listAreaModel = allListAreaModel;
      } else {
        listAreaModel = [];
        for (var element in allListAreaModel) {
          if (element.namaArea!.toLowerCase().contains(area.toLowerCase())) {
            listAreaModel.add(element);
          }
        }
      }

      listAreaString = [];
      for (var element in listAreaModel) {
        listAreaString.add(element.namaArea!);
      }
      selectedArea = listAreaString[0];
      // int idArea = listAreaModel[0].idArea!;
      // await getCaleg(idArea);
      notifyListeners();
    }
  }

  uploadData() async {
    log.i('uploadData');
    setBusy(true);
    easyLoading.customLoading('Uploading data...');
    globalVar.backPressed = 'cantBack';
    try {
      String idArea = listAreaModel[listAreaString.indexOf(selectedArea!)]
          .idArea
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
          'idArea': idArea,
          'nik': nik,
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
