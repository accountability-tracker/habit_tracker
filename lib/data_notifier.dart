import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataUpdate = StateNotifierProvider<IsUpdated, bool>((ref) {
  return IsUpdated();
});

class IsUpdated extends StateNotifier<bool> {
  IsUpdated() : super(false);
  void setUpdate() => state = !state;
}
