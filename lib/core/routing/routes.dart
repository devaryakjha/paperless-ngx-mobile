final class Routes {
  const Routes._();

  static const auth = 'auth';
  static const documents = 'documents';
}

extension RoutesX on String {
  String get location => '/$this';
}
