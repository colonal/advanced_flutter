class SliderObject {
  final String title;
  final String subTitle;
  final String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int numberOfSlides;
  final int currentIndex;

  SliderViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer({
    required this.id,
    required this.name,
    required this.numOfNotifications,
  });
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts({
    required this.phone,
    required this.email,
    required this.link,
  });
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication({
    this.customer,
    this.contacts,
  });
}

class ForgotAuthentication {
  final String password;
  ForgotAuthentication({
    required this.password,
  });
}
