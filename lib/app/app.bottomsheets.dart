// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/views/tim_survei_index_tracking/halaman_history/detail_suara_pemilih_bottom_sheet/detail_suara_pemilih_bottom_sheet_view.dart';
import '../ui/views/tim_survei_index_tracking/halaman_survei/bottom_sheet_cari_area/bottom_sheet_cari_area_view.dart';

enum BottomSheetType {
  bottomSheetCariAreaView,
  detailSuaraPemilihBottomSheetView,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.bottomSheetCariAreaView: (context, request, completer) =>
        BottomSheetCariAreaView(request: request, completer: completer),
    BottomSheetType.detailSuaraPemilihBottomSheetView:
        (context, request, completer) => DetailSuaraPemilihBottomSheetView(
            request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
