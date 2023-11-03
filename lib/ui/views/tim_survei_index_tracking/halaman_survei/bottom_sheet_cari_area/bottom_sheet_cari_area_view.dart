import 'package:cek_suara_app/ui/widgets/my_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import './bottom_sheet_cari_area_view_model.dart';

class BottomSheetCariAreaView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse)? completer;

  const BottomSheetCariAreaView({
    Key? key,
    required this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomSheetCariAreaViewModel>.reactive(
      viewModelBuilder: () => BottomSheetCariAreaViewModel(),
      onViewModelReady: (BottomSheetCariAreaViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        BottomSheetCariAreaViewModel model,
        Widget? child,
      ) {
        return SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: MyTextFormField(
              hintText: 'Cari Area',
              labelText: 'Cari Area',
              controller: model.searchController,
              suffixIcon: IconButton(
                onPressed: () {
                  completer!(
                    SheetResponse(
                      confirmed: true,
                      data: model.searchController.text,
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        );
      },
    );
  }
}
