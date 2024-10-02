final class Routes {
  const Routes._();

  static const auth = 'auth';
  static const documents = 'documents';
  static const home = 'home';
  static const scanner = 'scanner';
  static const labels = 'labels';
  static const settings = 'settings';
}

extension RoutesX on String {
  String get location => '/$this';
}
