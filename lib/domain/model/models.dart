import '../../data/mapper/mapper.dart';

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

class Service {
  int id;

  String title;

  String image;
  Service({
    required this.id,
    required this.title,
    required this.image,
  });
}

class BannersAd {
  int id;

  String title;
  String link;
  String image;
  BannersAd({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });
}

class Store {
  int id;

  String title;

  String image;
  Store({
    required this.id,
    required this.title,
    required this.image,
  });
}

class HomeData {
  List<Service> services;

  List<BannersAd> banners;

  List<Store> stores;
  HomeData({
    required this.services,
    required this.banners,
    required this.stores,
  });
}

class HomeObject {
  HomeData data;
  HomeObject(this.data);
}

class StoreDetails {
  int id;

  String title;
  String details;
  String image;
  String services;
  String about;
  StoreDetails({
    required this.id,
    required this.title,
    required this.image,
    required this.details,
    required this.about,
    required this.services,
  });
}

class NotificationObject {
  List<NotificationData> data;
  NotificationObject(this.data);
}

class NotificationData {
  final String image;
  final String title;
  final String body;
  final String date;
  final StateNotification state;

  NotificationData(this.image, this.title, this.body, this.date, this.state);
}

enum StateNotification {
  discount,
  newServise;
}

class SearchObject {
  List<SearchData> data;
  SearchObject(this.data);
}

class SearchData {
  int id;

  String title;

  String image;
  SearchData({
    required this.id,
    required this.title,
    required this.image,
  });
}
