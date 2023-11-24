// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/views/tim_survei_index_tracking/halaman_pengaturan/ganti_password_dialog/ganti_password_dialog_view.dart';

enum DialogType {
  gantiPasswordDialogView,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.gantiPasswordDialogView: (context, request, completer) =>
        GantiPasswordDialogView(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
