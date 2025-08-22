import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();
  factory TokenManager() => _instance;
  TokenManager._internal();

  static TokenManager get instance => _instance;

  static const String _tokenKey = 'auth_token';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    if (token.isNotEmpty) {
      await _secureStorage.write(key: _tokenKey, value: token);
    }
  }

  Future<String?> readToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  Future<bool> hasToken() async {
    final token = await readToken();
    return token != null && token.isNotEmpty;
  }
}
