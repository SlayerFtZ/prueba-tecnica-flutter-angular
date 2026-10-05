import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class Environment {
  static const _defaultBaseApiUrl = 'https://dummyjson.com';

  static Future<void> init() => dotenv.load(fileName: '.env');

  static String get baseApiUrl =>
      dotenv.maybeGet('VITE_API') ?? _defaultBaseApiUrl;

  static const connectTimeout = Duration(seconds: 10);
  static const receiveTimeout = Duration(seconds: 10);
  static const pageSize = 20;
}
