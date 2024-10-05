import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker internetChecker;

  NetworkInfoImp({required this.internetChecker});
  @override
  Future<bool> get isConnected async => await internetChecker.hasConnection;
}
