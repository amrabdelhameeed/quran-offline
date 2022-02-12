import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../constants/strings.dart';
import '../models/juz_model.dart';
import '../models/page_model.dart';
import '../models/surah_model.dart';
import '../repository/json_repo.dart';
part 'public_state.dart';

class PublicCubit extends Cubit<PublicState> {
  PublicCubit({required this.jsonRepository}) : super(PublicInitial());
  final JsonRepository jsonRepository;
  static PublicCubit get(context) => BlocProvider.of(context);
  bool ind = false;
  bool isListShowen = false;
  String surahName = "AL-fatiha";
  List<AllSurah> listOfSurahDetails = [];
  List<AllPages> listOfSurahDetailsForPages = [];
  List<AllJuz> listOfSurahDetailsForJuz = [];

  changeIndexDrawer(bool i) {
    ind = i;
    emit(ToggleIsListShownState());
  }

  List<AllSurah> allSurahDetails() {
    emit(PublicLoading());
    jsonRepository.readJsonAsModel().then((listOfSurahDetails) {
      this.listOfSurahDetails = listOfSurahDetails;
      emit(PublicLoaded(listOfSurahDetails));
    });
    return listOfSurahDetails;
  }

  List<AllPages> allSurahDetailsForPages() {
    emit(PublicLoading());
    jsonRepository.readJsonAsModelForPages().then((listOfSurahDetailsForPages) {
      this.listOfSurahDetailsForPages = listOfSurahDetailsForPages;
      emit(PublicLoadedForPages(listOfSurahDetailsForPages));
    });
    return listOfSurahDetailsForPages;
  }

  List<AllJuz> allSurahDetailsForJuz() {
    emit(PublicLoading());
    jsonRepository.readJsonAsModelForJuz().then((listOfSurahDetailsForJuz) {
      this.listOfSurahDetailsForJuz = listOfSurahDetailsForJuz;
      emit(PublicLoadedForJuz(listOfSurahDetailsForJuz));
    });
    return listOfSurahDetailsForJuz;
  }

  void changeSurahName(int index) {
    if (listOfSurahDetails[index].start.name !=
        listOfSurahDetails[index].end.name) {
      surahName = listOfSurahDetails[index].start.name +
          " $and " +
          listOfSurahDetails[index].end.name;
    } else {
      surahName = listOfSurahDetails[index].start.name;
    }

    emit(ChangeSurahNameState());
  }

  void toggleIsListShown() {
    isListShowen = !isListShowen;
    emit(ToggleIsListShownState());
  }

  List<String> surahsName() {
    List<String> surahNameList = [];
    listOfSurahDetailsForPages.forEach((element) {
      surahNameList.add(element.titleAr);
    });
    //juzaa();
    return surahNameList.toSet().toList();
  }

  int getSurahPageFromJuz(int juzNum) {
    print(juzNum);
    AllJuz mainJuzVerse = listOfSurahDetailsForJuz
        .firstWhere((element) => int.parse(element.index) == juzNum);
    // print(int.parse(listOfSurahDetails
    //     .firstWhere((surah) => (surah.start.verse == mainJuzVerse.start.verse &&
    //         surah.start.index == mainJuzVerse.start.index))
    //     .index));
    return int.parse(listOfSurahDetails
            .firstWhere((surah) =>
                ((surah.start.verse == mainJuzVerse.start.verse &&
                        surah.start.index == mainJuzVerse.start.index) ||
                    (surah.end.verse == mainJuzVerse.start.verse &&
                        surah.end.index == mainJuzVerse.start.index)))
            .index) -
        1;
  }
  // List<AllPages> juzaaList = [];
  // List<AllPages> juzaa() {
  //   List<String> juzaaStringList = [];
  //   listOfSurahDetailsForPages.forEach((element) {
  //     juzaaStringList.add(element.juz.first.index);
  //     juzaaStringList.toSet().toList();
  //   });
  //   juzaaStringList.forEach((juzaaString) {
  //     listOfSurahDetailsForPages.forEach((juzaa) {
  //      juzaaList.add(listOfSurahDetailsForPages.firstWhere((element) => element.juz.first.index==juz));
  //     });
  //   });
  //   print(juzaaList);
  //   return juzaaList;
  // }
}
