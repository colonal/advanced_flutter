import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworckInfo {
  Future<bool> get isConnected;
}

class NetworckInfoImpl extends NetworckInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworckInfoImpl(this.internetConnectionChecker);
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
