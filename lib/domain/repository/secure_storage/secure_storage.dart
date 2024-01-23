
import 'package:flap_basic/domain/entity/request_response.dart';
import 'package:flap_basic/domain/entity/storage_error.dart';

abstract class StorageService {
  Future<RequestResponse<String, StorageError>> writeJwt(String token);

  Future<RequestResponse<String?, StorageError>> readJwt();

  Future<RequestResponse<String, StorageError>> deleteJwt();
}
