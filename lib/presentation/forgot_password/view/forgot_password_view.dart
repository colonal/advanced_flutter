import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/forgot_password/viewModel/forgot_password_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class ForgotPassworedView extends StatefulWidget {
  const ForgotPassworedView({Key? key}) : super(key: key);

  @override
  State<ForgotPassworedView> createState() => _ForgotPassworedViewState();
}

class _ForgotPassworedViewState extends State<ForgotPassworedView> {
  final ForgetViewModel _viewModel = instance<ForgetViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _build() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setPassword(_userNameController.text));
  }

  @override
  void initState() {
    _build();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                print("Navigator");
                Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.forget();
                                  }
                                : null,
                            child: const Text(AppStrings.forgetPassword)),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
