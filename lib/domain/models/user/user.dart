import 'package:ddd_arch/domain/models/map_json.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    required String id,
    @Default('') String email,
  }) = _User;

  factory User.fromJson(MapJson json) => _$UserFromJson(json);
}
