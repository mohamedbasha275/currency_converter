/// Base class for all exceptions.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

/// Represents an exception that occurred during a server/API call.
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Represents an exception that occurred during local operations (cache, storage, etc.).
class CacheException extends AppException {
  const CacheException(super.message);
}
