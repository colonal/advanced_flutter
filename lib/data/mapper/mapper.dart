import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/domain/model/models.dart';

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
