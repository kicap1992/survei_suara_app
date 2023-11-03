import 'package:flutter/material.dart';

import '../../../../../app/app.logger.dart';
import '../../../../../app/core/custom_base_view_model.dart';

class BottomSheetCariAreaViewModel extends CustomBaseViewModel {
  final log = getLogger('BottomSheetCariAreaViewModel');

  TextEditingController searchController = TextEditingController();

  Future<void> init() async {}
}
