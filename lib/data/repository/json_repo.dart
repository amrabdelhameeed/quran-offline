import '../models/juz_model.dart';
import '../models/page_model.dart';
import '../models/surah_model.dart';
import '../rootBundle/root_bundle.dart';

class JsonRepository {
  final RootBundle root;
  JsonRepository(this.root);
  Future<List<AllSurah>> readJsonAsModel() async {
    List<dynamic> data = [];
    await root.readJson().then((value) {
      data = value;
    });
    return data.map((e) => AllSurah.fromJson(e)).toList();
  }

  Future<List<AllPages>> readJsonAsModelForPages() async {
    List<dynamic> data = [];
    await root.readJsonPages().then((value) {
      data = value;
    });
    return data.map((e) => AllPages.fromJson(e)).toList();
  }

  Future<List<AllJuz>> readJsonAsModelForJuz() async {
    List<dynamic> data = [];
    await root.readJsonJuz().then((value) {
      data = value;
    });
    return data.map((e) => AllJuz.fromJson(e)).toList();
  }
}
