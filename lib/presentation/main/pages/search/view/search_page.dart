import '../../../../../app/di.dart';
import '../../../../../domain/model/models.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../viewmodel/search_viewmolel.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/string_manager.dart';
import '../../../../resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchViewmodel _viewmodel = instance<SearchViewmodel>();
  final TextEditingController _serchController = TextEditingController();

  @override
  void initState() {
    _viewmodel.start();
    _serchController.addListener(() {
      _viewmodel.setSearch(_serchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    _serchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewmodel.outputState,
      builder: (context, snapshot) {
        return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                _getContentWidget(),
                snapshot.data != null
                    ? Expanded(child: _streamSearchData())
                    : Expanded(child: Container()),
              ],
            ),
            snapshot.data?.getScreenWidget(context, Container(), () {
                  _viewmodel.start();
                }) ??
                Container(),
          ],
        );
      },
    );
  }

  Padding _getContentWidget() {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s30, vertical: AppSize.s28),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _serchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.searchServise.tr(),
                      enabledBorder: InputBorder.none,
                      suffixIcon: Icon(Icons.search, color: theme.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s20),
        ],
      ),
    );
  }

  _streamSearchData() {
    return StreamBuilder<SearchObject?>(
      stream: _viewmodel.outpotSearch,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Lottie.asset(JsonAssets.searchEmpty);
        }
        return ListView.separated(
          itemCount: snapshot.data!.data.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.all(AppSize.s8),
            child: Divider(
              thickness: 2,
              endIndent: AppSize.s30,
              indent: AppSize.s30,
            ),
          ),
          itemBuilder: (context, index) =>
              _buldItemWidget(search: snapshot.data!.data[index]),
        );
      },
    );
  }

  _buldItemWidget({required SearchData search}) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
      child: ListTile(
        title: Text(search.title, style: theme.textTheme.titleMedium),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Image.network(search.image),
        ),
      ),
    );
  }
}
