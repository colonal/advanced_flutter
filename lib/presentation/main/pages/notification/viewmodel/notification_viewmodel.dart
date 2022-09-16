import 'dart:async';
import 'dart:ffi';

import '../../../../../domain/model/models.dart';
import '../../../../../domain/usecase/notification_usecase.dart';
import '../../../../base/baseviewmodel.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assets_manager.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class NotificationVewmodel extends BaseViewModel
    with NotificationViewModelInput, NotificationViewModelOutput {
  final NotificationUsecase usecase;

  final StreamController<NotificationObject>
      _notificationObjectStreamController =
      BehaviorSubject<NotificationObject>();

  NotificationVewmodel({required this.usecase});

  @override
  Sink get inputNotification => _notificationObjectStreamController.sink;

  @override
  Stream<NotificationObject> get outputNotification =>
      _notificationObjectStreamController.stream
          .map((notificationObject) => notificationObject);

  @override
  void start() {
    _getStoreDetails();
  }

  @override
  void dispose() {
    _notificationObjectStreamController.close();
    super.dispose();
  }

  static NotificationObject? _notificationObject;
  void _getStoreDetails() async {
    if (_notificationObject != null) {
      _notificationObjectStreamController.add(_notificationObject!);
    } else {
      inputState.add(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));

      (await usecase.execute(Void)).fold(
        (failure) => inputState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: failure.message)),
        (notificationObject) {
          inputState.add(ContentState());
          _notificationObject = notificationObject;
          _notificationObjectStreamController.add(notificationObject);
        },
      );
    }
  }

  String getIcon(StateNotification state) {
    switch (state) {
      case StateNotification.discount:
        return JsonAssets.discount;
      case StateNotification.newServise:
        return JsonAssets.newServise;
      default:
        return JsonAssets.discount;
    }
  }

  String getDate(String date) {
    final DateTime now = DateTime.now();
    final DateFormat df = DateFormat('yyyy/MM/dd hh:mm a');
    final DateTime formattedDateTimeAfter = df.parse(date);
    final DateTime formattedDateTimeNow = df.parse(df.format(now));

    Duration diff = formattedDateTimeNow.difference(formattedDateTimeAfter);

    return getDataAgo(diff);
  }

  String getDataAgo(Duration duration) {
    String? ago;
    if (duration.inDays > 360) {
      ago = "${duration.inDays / 360} year Ago";
    } else if (duration.inDays > 30) {
      ago = "${duration.inDays / 30} Month Ago";
    } else if (duration.inDays > 0) {
      ago = "${duration.inDays} Day Ago";
    } else if (duration.inHours > 0) {
      ago = "${duration.inHours} Hours Ago";
    } else if (duration.inMinutes > 0) {
      ago = "${duration.inMinutes} Minutes Ago";
    } else {
      ago = "${duration.inSeconds} Seconde Ago";
    }
    return ago;
  }
}

abstract class NotificationViewModelInput {
  Sink get inputNotification;
}

abstract class NotificationViewModelOutput {
  Stream<NotificationObject> get outputNotification;
}
