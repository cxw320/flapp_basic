import 'package:flap_basic/domain/entity/request_response.dart';
import 'package:flap_basic/domain/entity/storage_error.dart';
import 'package:flap_basic/domain/repository/secure_storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageImpl extends StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _jwtTokenKey = 'jwt_token';

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<RequestResponse<String, StorageError>> readJwt() async {
    try {
      final data = await _secureStorage.read(
          key: _jwtTokenKey, aOptions: _getAndroidOptions());
      if (data != null) {
        return SuccessRequestResponse(data);
      } else {
        return const ErrorRequestResponse(StorageError.readError);
      }
    } on Exception catch (_) {
      return const ErrorRequestResponse(StorageError.readError);
    }
  }

  @override
  Future<RequestResponse<String, StorageError>> deleteJwt() async {
    try {
      await _secureStorage.delete(
          key: _jwtTokenKey, aOptions: _getAndroidOptions());
      return const SuccessRequestResponse('Successfully deleted JWT');
    } on Exception catch (_) {
      return const ErrorRequestResponse(StorageError.deleteError);
    }
  }

  @override
  Future<RequestResponse<String, StorageError>> writeJwt(String token) async {
    try {
      await _secureStorage.write(
          key: _jwtTokenKey, value: token, aOptions: _getAndroidOptions());
      return const SuccessRequestResponse('Successfully saved JWT');
    } on Exception catch (_) {
      return const ErrorRequestResponse(StorageError.writeError);
    }
  }
}
