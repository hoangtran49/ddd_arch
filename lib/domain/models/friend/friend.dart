import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend.freezed.dart';

@freezed
class Friend with _$Friend {
  const factory Friend({
    required String name,
    String? phone,
    int? id,
  }) = _Friend;
}
