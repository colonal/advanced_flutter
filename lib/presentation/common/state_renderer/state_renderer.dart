import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/font_manager.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

enum StateRendererType {
  //  POPUP STATES (IDALOG)
  popupLoadingStat,
  popupErrorstate,
  popupInfostate,

  // FULL SCREEN STATED (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  fullScreenInfo,

  // Widget
  progressBarWidget,

  // general
  contentState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionFunction;
  final Widget? content;
  const StateRenderer(
      {required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryActionFunction,
      this.content,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(message, context, content: content);
  }

  Widget _getStateWidget(String message, BuildContext context,
      {Widget? content}) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingStat:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorstate:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getReteyButton(AppStrings.ok.tr(), context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemColumn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);

      case StateRendererType.fullScreenErrorState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getReteyButton(AppStrings.retryAgain.tr(), context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      case StateRendererType.contentState:
        break;
      case StateRendererType.popupInfostate:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getReteyButton(AppStrings.ok.tr(), context),
        ]);
      case StateRendererType.fullScreenInfo:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.success),
          _getMessage(message),
          _getReteyButton(AppStrings.ok.tr(), context)
        ]);
      case StateRendererType.progressBarWidget:
        return _getProgressBarWidget(context);
    }
    return Container();
  }

  Widget _getItemColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s18),
        ),
      ),
    );
  }

  Widget _getReteyButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (stateRendererType ==
                      StateRendererType.fullScreenErrorState) {
                    retryActionFunction.call();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(buttonTitle))),
      ),
    );
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(color: Colors.black26),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _getProgressBarWidget(BuildContext context) {
    return LinearProgressIndicator(
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).disabledColor,
      minHeight: 10,
    );
  }
}
