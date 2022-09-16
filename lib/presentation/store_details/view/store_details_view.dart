import '../../../app/di.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/store_details_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/models.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  String? _title;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(
          _title ?? AppStrings.storeDetails.tr(),
          style: theme.textTheme.titleSmall,
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.start();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  _getContentWidget() {
    return StreamBuilder<StoreDetails>(
      stream: _viewModel.outputStoreDetails,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        _title = snapshot.data!.title;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p28, vertical: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: AppSize.s160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.lightGrey.withOpacity(0.5),
                        ColorManager.darkGrey,
                      ],
                    ),
                    image: DecorationImage(
                      image: NetworkImage(snapshot.data!.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                _buildItime(
                    title: AppStrings.details.tr(),
                    body: snapshot.data!.details),
                const SizedBox(height: AppSize.s20),
                _buildItime(
                    title: AppStrings.services.tr(),
                    body: snapshot.data!.services),
                const SizedBox(height: AppSize.s20),
                _buildItime(
                    title: AppStrings.aboutStore.tr(),
                    body: snapshot.data!.about),
                const SizedBox(height: AppSize.s40),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildItime({required String title, required String body}) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall!.copyWith(
            fontSize: FontSize.s22,
          ),
        ),
        const SizedBox(height: AppSize.s8),
        Text(
          body,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: FontSize.s16,
          ),
        )
      ],
    );
  }
}
