import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';

import '../response/responses.dart';

import '../../app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id.orEmpty() ?? Constants.empty,
      name: this?.name.orEmpty() ?? Constants.empty,
      numOfNotifications: this?.numOfNotifications.orZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      phone: this?.phone.orEmpty() ?? Constants.empty,
      email: this?.email.orEmpty() ?? Constants.empty,
      link: this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(
      customer: customer.toDomain(),
      contacts: contacts.toDomain(),
    );
  }
}

extension ForgotAuthenticationMapper on ForgetResponse {
  ForgotAuthentication toDomain() {
    return ForgotAuthentication(
      password: password ?? Constants.empty,
    );
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id.orZero() ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      image: this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannersAd toDomain() {
    return BannersAd(
      id: this?.id.orZero() ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      image: this?.image.orEmpty() ?? Constants.empty,
      link: this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id.orZero() ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      image: this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> service = this
            ?.data
            ?.services
            ?.map((serviceResponse) => serviceResponse.toDomain())
            .toList() ??
        const Iterable.empty().cast<Service>().toList();
    List<BannersAd> banners = this
            ?.data
            ?.banners
            ?.map((bannersResponse) => bannersResponse.toDomain())
            .toList() ??
        const Iterable.empty().cast<BannersAd>().toList();
    List<Store> stores = this
            ?.data
            ?.stores
            ?.map((storesResponse) => storesResponse.toDomain())
            .toList() ??
        const Iterable.empty().cast<Store>().toList();

    HomeData data = HomeData(
      services: service,
      banners: banners,
      stores: stores,
    );
    return HomeObject(data);
  }
}

extension StoreDetailsMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      id: this?.id.orZero() ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      image: this?.image.orEmpty() ?? Constants.empty,
      details: this?.details.orEmpty() ?? Constants.empty,
      about: this?.about.orEmpty() ?? Constants.empty,
      services: this?.services.orEmpty() ?? Constants.empty,
    );
  }
}

extension NotificationMepper on NotificationResponse {
  NotificationObject toDomain() {
    List<NotificationData> notificationData = data
            ?.map((data) => NotificationData(
                  data.image ?? Constants.empty,
                  data.title ?? Constants.empty,
                  data.body ?? Constants.empty,
                  data.date ?? Constants.empty,
                  _getState(data.state ?? Constants.empty),
                ))
            .toList() ??
        const Iterable.empty().cast<NotificationData>().toList();
    return NotificationObject(notificationData);
  }

  StateNotification _getState(String s) {
    switch (s) {
      case "discount":
        return StateNotification.discount;
      case "new":
        return StateNotification.newServise;
      default:
        return StateNotification.discount;
    }
  }
}
