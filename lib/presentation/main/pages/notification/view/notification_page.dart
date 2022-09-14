import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/main/pages/notification/viewmodel/notification_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/font_manager.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationVewmodel _viewModel = instance<NotificationVewmodel>();

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
              _viewModel.start();
            }) ??
            _getContentWidget();
      },
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder(
      stream: _viewModel.outputNotification,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppSize.s30, horizontal: AppSize.s14),
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: ListView.separated(
                itemCount: snapshot.data!.data.length,
                separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSize.s10, horizontal: AppSize.s14),
                    child: Divider(thickness: 1.1)),
                itemBuilder: (context, index) {
                  return _buildNotificationItme(snapshot.data!.data[index]);
                },
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildNotificationItme(NotificationData data) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: AppSize.s100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  data.image,
                  fit: BoxFit.cover,
                  width: AppSize.s100,
                  height: AppSize.s70,
                ),
              ),
              Transform.translate(
                offset: const Offset(-AppSize.s12, AppSize.s12),
                child: Lottie.asset(_viewModel.getIcon(data.state),
                    width: AppSize.s40, height: AppSize.s40),
              ),
            ],
          ),
          const SizedBox(width: AppSize.s14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.title,
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        _viewModel.getDate(data.date),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                Flexible(
                  child: Text(
                    data.body,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "more details ",
                      style: theme.textTheme.labelSmall,
                    ),
                    SvgPicture.asset(ImageAssets.settingsRightArrowIc),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
