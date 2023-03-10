part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class RequestSubcribeSettingEvent extends SettingEvent {}

class UpdateThemeEvent extends SettingEvent {}

class ChangeLanguageEvent extends SettingEvent {}
