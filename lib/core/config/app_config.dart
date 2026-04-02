import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized configuration for connecting the app to the backend.
///
/// Uses `.env` (loaded in `main.dart`) when available, otherwise falls back to
/// the production backend you provided.
class AppConfig {
  static const String apiPrefix = '/api/v1';

  /// Root API URL without `/api/v1`.
  ///
  /// Example (production): `https://job-backend-mj9t.vercel.app`
  static String get apiBaseUrl {
    final fromEnv = dotenv.env['API_ROOT'];
    if (fromEnv == null || fromEnv.trim().isEmpty) {
      return 'https://job-backend-mj9t.vercel.app';
    }
    return fromEnv.trim();
  }
}

