import 'dart:io';

sealed class NetworkInfo {
  const NetworkInfo();
  Future<bool> isConnected();
}

class NetworkInfoImplementation implements NetworkInfo {
  @override
  Future<bool> isConnected() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }
}