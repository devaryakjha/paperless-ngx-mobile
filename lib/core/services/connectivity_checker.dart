import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

abstract interface class ConnectivityChecker {
  const ConnectivityChecker();

  Future<bool> isConnected();
  Stream<bool> connectivityChanges();
  Future<bool> isPaperlessServerReachable(String serverUrl);
}

final class ConnectivityCheckerImpl implements ConnectivityChecker {
  const ConnectivityCheckerImpl(this._connectivity);

  final Connectivity _connectivity;

  bool _hasValidConnection(List<ConnectivityResult> result) {
    return result != [ConnectivityResult.none];
  }

  @override
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return _hasValidConnection(result);
  }

  @override
  Stream<bool> connectivityChanges() {
    return _connectivity.onConnectivityChanged.map(_hasValidConnection);
  }

  @override
  Future<bool> isPaperlessServerReachable(String serverUrl) async {
    try {
      final response = await http.get(Uri.parse('$serverUrl/api/'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
