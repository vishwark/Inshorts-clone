import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isDisConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult[0] == ConnectivityResult.none;
  }
}
