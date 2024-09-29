final class Routes {
  const Routes._();

  static const auth = 'auth';
}

extension RoutesX on String {
  String get location => '/$this';
}
