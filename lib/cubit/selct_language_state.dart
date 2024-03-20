part of 'selct_language_cubit.dart';

@immutable
sealed class SelctLanguageState {}

final class SelctLanguageInitial extends SelctLanguageState {}

final class SelctLanguageLooding extends SelctLanguageState {}

final class SelctLanguageSuccses extends SelctLanguageState {}

final class SelctLanguageFaliuer extends SelctLanguageState {}
