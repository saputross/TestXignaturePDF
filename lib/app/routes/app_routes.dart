// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const PDF = _Paths.PDF;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const PDF = '/pdf';
}
