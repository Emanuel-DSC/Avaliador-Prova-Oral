import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _key = 'avaliacoes';
  static const String _timestampKey = 'avaliacoes_timestamp';

  static Future<void> saveData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(data));
    await prefs.setString(_timestampKey, DateTime.now().toIso8601String());
  }

  static Future<Map<String, dynamic>?> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    final timestampStr = prefs.getString(_timestampKey);

    if (json == null || timestampStr == null) return null;

    final timestamp = DateTime.tryParse(timestampStr);
    final now = DateTime.now();

    if (timestamp == null || now.difference(timestamp).inHours >= 24) {
      await clearData();
      return null;
    }

    return jsonDecode(json);
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    await prefs.remove(_timestampKey);
  }
}
