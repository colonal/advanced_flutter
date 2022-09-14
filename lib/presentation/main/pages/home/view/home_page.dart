import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _viewModel.dispose();
    super.deactivate();
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
        stream: _viewModel.outputHomeObject,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getBannerWidget(snapshot.data!.banners),
              _getSection(AppStrings.services.tr()),
              _getServiceWidget(snapshot.data!.services),
              _getSection(AppStrings.stores.tr()),
              _getStoreWidget(snapshot.data!.stores),
            ],
          );
        });
  }

  Widget _getSection(String text) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getBannerWidget(List<BannersAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map(
              (benner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: BorderSide(
                          color: ColorManager.primary, width: AppSize.s1)),
                  child: _buildImageNetwork(benner.image),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getServiceWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s160,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView.builder(
            itemCount: services.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                elevation: AppSize.s4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  side:
                      BorderSide(color: ColorManager.white, width: AppSize.s1),
                ),
                child: Column(
                  children: [
                    _buildImageNetwork(services[index].image,
                        height: AppSize.s120, width: AppSize.s120),
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p8),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          services[index].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoreWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2.toInt(),
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.storeDetailsRoute, arguments: "1");
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildImageNetwork(String image, {double? width, double? height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
