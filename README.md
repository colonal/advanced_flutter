# Flutter Advanced - Clean Architecture With MVVM 


# project outcome
<h4> *  Clean Architecture Design Pattern</h4>
<h4> *  MVVM - Model - View - View Model Pattern</h4>
<h4> *  ViewModel Inputs and Outputs</h4>
<h4> *  Base ViewModel and Base UseCase</h4>
<h4> *  Application Layer - Dependency Injection, Routes Manager and Application class</h4>
<h4> *  Application Layer - Extensions and Shared Functions</h4>
<h4> *  Data Layer - Data Sources (Remote Data Source/ Local Data Source)</h4>
<h4> *  Data Layer - API Service Client (Same as Retorfit in Android)</h4>
<h4> *  Data Layer - Calling APIs (Remote Data Source)</h4>
<h4> *  Data Layer - Adding Logger Interceptor</h4>
<h4> *  Data Layer - Caching APIs responses (Local Data Source)</h4>
<h4> *  Data Layer - Json Serialization and Annotations</h4>
<h4> *  Data Layer - Repository Implementation</h4>
<h4> *  Data Layer - Mapper (Converting responses into Models)</h4>
<h4> *  Data Layer - Mapper (Using toDomain Concept)</h4>
<h4> *  Data Layer - Applying Null Safety</h4>
<h4> *  Data Layer - Creating Mock APIs (Stub APIs)</h4>
<h4> *  Domain Layer - Models</h4>
<h4> *  Domain Layer - Repository Interfaces</h4>
<h4> *  Domain Layer - UseCases</h4>
<h4> *  Domain Layer - Either Concepts (Left - Failure) / (Right - Success)</h4>
<h4> *  Domain Layer - Data Classes</h4>
<h4> *  Presentation Layer - UI (Splash - Onboarding - Login - Register - Forgot Password - Main - Details - Settings - Notification - Search))</h4>
<h4> *  Presentation Layer - State Renderer (Full Screen States - Popup States)</h4>
<h4> *  Presentation Layer - State Management (Stream Controller - RX Dart - Stream Builder)</h4>
<h4> *  Presentation Layer - Localisations (English - Arabic), (RTL - LTR)</h4>
<h4> *  Presentation Layer - Assets Manager (Android and Ios Icons and Images sizes)</h4>
<h4> *  Presentation Layer - (Fonts - Styles - Themes - Strings - Values - Colors) Managers</h4>
<h4> *  Presentation Layer - Using Json Animations</h4>
<h4> *  Presentation Layer - Using SVG images</h4>
<h4> *  Using 18 Flutter Packages</h4>
<h4> *  Getting Device Info (Android - Ios)</h4>
<h4> *  Using Abstract classes</h4>
<br><br>

# Screenshot
  <img src="screenshot/1.png" height="250em" /> <img src="screenshot/2.png" height="250em" />
  <img src="screenshot/3.png" height="250em" /> <img src="screenshot/4.png" height="250em" />
  <img src="screenshot/5.png" height="250em" /> <img src="screenshot/6.png" height="250em" />
  <img src="screenshot/7.png" height="250em" /> <img src="screenshot/8.png" height="250em" />
  <img src="screenshot/9.png" height="250em" />


<br><br>
# Project Tree
```
advanced_flutter
.
├── app
│   ├── app_preferences.dart
│   ├── app.dart
│   ├── constants.dart
│   ├── di.dart
│   ├── extensions.dart
│   └── functions.dart
├── data
│   ├── data_sourse
│   │   ├── local_data_source.dart
│   │   └── remotr_data_sourse.dart
│   ├── mapper
│   │   └── mapper.dart
│   ├── network
│   │   ├── app_api.dart
│   │   ├── app_api.g.dart
│   │   ├── dio_factory.dart
│   │   ├── error_handler.dart
│   │   ├── failure.dart
│   │   ├── network_info.dart
│   │   └── requests.dart
│   ├── repository
│   │   └── repository_impl.dart
│   └── response
│       ├── responses.dart
│       └── responses.g.dart
├── domain
│   ├── model
│   │   └── models.dart
│   ├── repository
│   │   └── repository.dart
│   └── usecase
│       ├── base_usecase.dart
│       ├── forgot_usecase.dart
│       ├── home_usecase.dart
│       ├── login_usecase.dart
│       ├── notification_usecase.dart
│       ├── register_usecase.dart
│       ├── search_usecase.dart
│       └── store_details_usecase.dart
├── presentation
│   ├── base
│   │   └── baseviewmodel.dart
│   ├── common
│   │   ├── state_renderer
│   │   │   ├── state_renderer_impl.dart
│   │   │   └── state_renderer.dart
│   │   ├── freezed_data_classes.dart
│   │   └── freezed_data_classes.freezed.dart
│   ├── forgot_password
│   │   ├── view
│   │   │   └── forgot_password_view.dart
│   │   └── viewModel
│   │       └── forgot_password_viewmodel.dart
│   ├── login
│   │   ├── view
│   │   │   └── lodin_view.dart
│   │   └── viewmodel
│   │       └── login_viewmodel.dart
│   ├── main
│   │   ├── pages
│   │   │   ├── home
│   │   │   │   ├── view
│   │   │   │   │   └── home_page.dart
│   │   │   │   └── viewmodel
│   │   │   │       └── home_viewmodel.dart
│   │   │   ├── notification
│   │   │   │   ├── view
│   │   │   │   │   └── notification_page.dart
│   │   │   │   └── viewmodel
│   │   │   │       └── notification_viewmodel.dart
│   │   │   ├── search
│   │   │   │   ├── view
│   │   │   │   │   └── search_page.dart
│   │   │   │   └── viewmodel
│   │   │   │       └── search_viewmolel.dart
│   │   │   └── setting
│   │   │       └── setting_page.dart
│   │   └── main_view.dart
│   ├── on_boarding
│   │   ├── view
│   │   │   └── on_bparding_view.dart
│   │   └── viewmodel
│   │       └── onboarding_viewmodel.dart
│   ├── register
│   │   ├── view
│   │   │   └── register_view.dart
│   │   └── view_model
│   │       └── register_viewmodel.dart
│   ├── resources
│   │   ├── assets_manager.dart
│   │   ├── color_manager.dart
│   │   ├── constants_manager.dart
│   │   ├── font_manager.dart
│   │   ├── langauges_manager.dart
│   │   ├── routes_manager.dart
│   │   ├── string_manager.dart
│   │   ├── styles_manager.dart
│   │   ├── theme_manager.dart
│   │   └── values_manager.dart
│   ├── splash
│   │   └── splash_view.dart
│   └── store_details
│       ├── view
│       │   └── store_details_view.dart
│       └── viewmodel
│           └── store_details_viewmodel.dart
└── main.dart
```