import 'dart:convert';
import 'package:flutter/services.dart';

class RootBundle {
  Future<List<dynamic>> readJson() async {
    final String response = await rootBundle.loadString('lib/assets/page.json');
    final data = await json.decode(response);
    return data["allSurah"];
  }

  Future<List<dynamic>> readJsonPages() async {
    final String response =
        await rootBundle.loadString('lib/assets/surah.json');
    final data = await json.decode(response);
    return data["allSurahDetails"];
  }

  Future<List<dynamic>> readJsonJuz() async {
    final String response = await rootBundle.loadString('lib/assets/juz.json');
    final data = await json.decode(response);
    return data["allJuz"];
  }
}
