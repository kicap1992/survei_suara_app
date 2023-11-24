import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

import '../services/global_var.dart';
import '../services/http_services.dart';
import '../services/my_easyloading.dart';
import '../services/other_function.dart';

import '../services/shared_prefs.dart';
import '../ui/views/login_screen/login_screen_view.dart';
import '../ui/views/splash_screen/splash_screen_view.dart';
import '../ui/views/tim_survei_index_tracking/first_page/first_page_view.dart';
import '../ui/views/tim_survei_index_tracking/halaman_history/halaman_history_view.dart';
import '../ui/views/tim_survei_index_tracking/halaman_pengaturan/ganti_password_dialog/ganti_password_dialog_view.dart';
import '../ui/views/tim_survei_index_tracking/halaman_pengaturan/halaman_pengaturan_view.dart';

import '../ui/views/tim_survei_index_tracking/halaman_survei/bottom_sheet_cari_area/bottom_sheet_cari_area_view.dart';
import '../ui/views/tim_survei_index_tracking/halaman_history/detail_suara_pemilih_bottom_sheet/detail_suara_pemilih_bottom_sheet_view.dart';
import '../ui/views/tim_survei_index_tracking/halaman_survei/halaman_survei_view.dart';
import '../ui/views/tim_survei_index_tracking/tim_survei_index_tracking_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: LoginScreenView),
    MaterialRoute(
      page: TimSurveiIndexTrackingView,
      children: [
        MaterialRoute(page: FirstPageView, initial: true),
        MaterialRoute(page: HalamanSurveiView),
        MaterialRoute(page: HalamanHistoryView),
        MaterialRoute(page: HalamanPengaturanView)
      ],
    ),
  ],
  dialogs: [
    StackedDialog(classType: GantiPasswordDialogView),
    // StackedDialog(classType: TambahDetailTimSurveiView)
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    // this below is mine
    LazySingleton(classType: MyEasyLoading),
    LazySingleton(classType: MyHttpServices),
    LazySingleton(classType: GlobalVar),
    LazySingleton(classType: MyFunction),
    LazySingleton(classType: MySharedPrefs)
  ],
  logger: StackedLogger(),
  bottomsheets: [
    StackedBottomsheet(classType: BottomSheetCariAreaView),
    StackedBottomsheet(classType: DetailSuaraPemilihBottomSheetView)
  ],
)
class App {}
