import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract interface class ConnectivityChecker {
  const ConnectivityChecker();

  /// Returns `true` if the device is connected to a network, `false` otherwise.
  Future<bool> isConnected();

  /// Returns a stream of booleans that emit `true`
  /// when the device is connected to a network
  Stream<bool> connectivityChanges();

  /// Returns `true` if the server at [serverUrl] is reachable,
  /// `false` otherwise.
  Future<bool> isServerReachable(Uri serverUrl);
}

@Singleton(as: ConnectivityChecker)
final class ConnectivityCheckerImpl implements ConnectivityChecker {
  ConnectivityCheckerImpl() : _connectivity = Connectivity();

  final Connectivity _connectivity;

  bool _hasValidConnection(List<ConnectivityResult> result) {
    return result != [ConnectivityResult.none];
  }

  @override
  Future<bool> isConnected() async =>
      _hasValidConnection(await _connectivity.checkConnectivity());

  @override
  Stream<bool> connectivityChanges() async* {
    yield await isConnected();
    yield* _connectivity.onConnectivityChanged.map(_hasValidConnection);
  }

  @override
  Future<bool> isServerReachable(Uri serverUrl) async {
    try {
      final response = await http.get(cleanupServerUrl(serverUrl));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

Uri cleanupServerUrl(Uri serverUrl) {
  var newUri = serverUrl;
  if (newUri.scheme.isEmpty) {
    newUri = newUri.replace(scheme: 'https');
  }

  // if the url isn't ending with /api/ add it
  if (!newUri.path.endsWith('/api/')) {
    newUri = newUri.replace(path: '${newUri.path}/api/');
  }

  // if the url isn't ending with / add it
  if (!newUri.path.endsWith('/')) {
    newUri = newUri.replace(path: '${newUri.path}/');
  }

  return newUri;
}
