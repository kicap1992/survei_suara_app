// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/views/tim_survei_index_tracking/halaman_survei/bottom_sheet_cari_area/bottom_sheet_cari_area_view.dart';

enum BottomSheetType {
  bottomSheetCariAreaView,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.bottomSheetCariAreaView: (context, request, completer) =>
        BottomSheetCariAreaView(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
