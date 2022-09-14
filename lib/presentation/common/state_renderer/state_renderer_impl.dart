import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';

import '../../resources/string_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererTyp();
  String getMessage();
}

// forgot
class ForgotState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  ForgotState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() => stateRendererType;
}

// loading state(POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() => stateRendererType;
}

// Error state(POPUP, FULL SCREEN)

class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  ErrorState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() => stateRendererType;
}

// Show Info(POPUP, FULL SCREEN)

class ShowInfoState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  ShowInfoState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() => stateRendererType;
}

// content state
class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererTyp() => StateRendererType.contentState;
}

// empty state
class EmptyState extends FlowState {
  final String message;
  EmptyState({required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererTyp() == StateRendererType.popupLoadingStat) {
            // show popup loading
            showPopup(context, getStateRendererTyp(), getMessage());
            // show content ui
            return contentScreenWidget;
          } else {
            // Full Screen loading State
            return StateRenderer(
              stateRendererType: getStateRendererTyp(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ForgotState:
        {
          if (getStateRendererTyp() == StateRendererType.popupLoadingStat) {
            // show popup loading
            showPopup(context, getStateRendererTyp(), getMessage());
            // show content ui
            return contentScreenWidget;
          } else {
            // Full Screen loading State
            return StateRenderer(
              stateRendererType: getStateRendererTyp(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererTyp() == StateRendererType.popupErrorstate) {
            // show popup Error
            showPopup(context, getStateRendererTyp(), getMessage());
            // show content ui
            return contentScreenWidget;
          } else {
            // Full Screen Error State
            return StateRenderer(
              stateRendererType: getStateRendererTyp(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ShowInfoState:
        {
          dismissDialog(context);
          if (getStateRendererTyp() == StateRendererType.popupInfostate) {
            // show popup Error
            showPopup(context, getStateRendererTyp(), getMessage());
            // show content ui
            return contentScreenWidget;
          } else {
            // Full Screen Error State
            return StateRenderer(
              stateRendererType: getStateRendererTyp(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererTyp(),
            message: getMessage(),
            retryActionFunction: () {},
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {},
          );
        },
      );
    });
  }

  // TODO chack
  bool _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
