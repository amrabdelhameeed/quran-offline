part of 'public_cubit.dart';

@immutable
abstract class PublicState {}

class PublicInitial extends PublicState {}

class PublicLoading extends PublicState {}

class PublicLoaded extends PublicState {
  final List<AllSurah> allSurah;
  PublicLoaded(this.allSurah);
}

class ChangeSurahNameState extends PublicState {}

class ToggleIsListShownState extends PublicState {}

class PublicLoadedForPages extends PublicState {
  final List<AllPages> allSurah;
  PublicLoadedForPages(this.allSurah);
}

class PublicLoadedForJuz extends PublicState {
  final List<AllJuz> allSurah;
  PublicLoadedForJuz(this.allSurah);
}
