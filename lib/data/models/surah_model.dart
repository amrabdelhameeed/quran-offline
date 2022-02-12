class SurahModel {
  SurahModel({
    required this.allSurah,
  });
  late final List<AllSurah> allSurah;

  SurahModel.fromJson(Map<String, dynamic> json) {
    allSurah =
        List.from(json['allSurah']).map((e) => AllSurah.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['allSurah'] = allSurah.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AllSurah {
  AllSurah({
    required this.index,
    required this.start,
    required this.end,
  });
  late final String index;
  late final Start start;
  late final End end;

  AllSurah.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    start = Start.fromJson(json['start']);
    end = End.fromJson(json['end']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['index'] = index;
    _data['start'] = start.toJson();
    _data['end'] = end.toJson();
    return _data;
  }
}

class Start {
  Start({
    required this.index,
    required this.verse,
    required this.name,
    required this.nameAr,
  });
  late final String index;
  late final String verse;
  late final String name;
  late final String nameAr;

  Start.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    verse = json['verse'];
    name = json['name'];
    nameAr = json['nameAr'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['index'] = index;
    _data['verse'] = verse;
    _data['name'] = name;
    _data['nameAr'] = nameAr;
    return _data;
  }
}

class End {
  End({
    required this.index,
    required this.verse,
    required this.name,
    required this.nameAr,
  });
  late final String index;
  late final String verse;
  late final String name;
  late final String nameAr;

  End.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    verse = json['verse'];
    name = json['name'];
    nameAr = json['nameAr'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['index'] = index;
    _data['verse'] = verse;
    _data['name'] = name;
    _data['nameAr'] = nameAr;
    return _data;
  }
}
