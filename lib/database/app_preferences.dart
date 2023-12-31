import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AppPreferences extends GetxController {
  final _storage = GetStorage();

  // Salva dado localmente em segurança
  Future<void> saveLocalData({required String key, required String data}) async {
    await _storage.write(key, data);
  }

  // Salva dado localmente em segurança
  void clear() async {
    await _storage.erase();
  }

  // Recupera dado salvo localmente em segurança
  String? getLocalData({required String key}) {
    return _storage.read(key);
  }

  // Remove dado salvo localmente
  void removeLocalData({required String key}) {
    _storage.remove(key);
  }


}
