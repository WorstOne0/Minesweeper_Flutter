// Flutter Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

// (https://pub.dev/packages/hive)
class HiveStorage {
  final hiveBox = Hive.lazyBox("wikidadosBox");

  Future<bool> save(String key, String value) async {
    try {
      await hiveBox.put(key, value);

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<String?> read(String key) async {
    return await hiveBox.get(key);
  }

  void deleteKey(String key) async {
    hiveBox.delete(key);
  }
}

final hiveStorageProvider = Provider<HiveStorage>((ref) => HiveStorage());
