import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataUpdate = StateNotifierProvider<isUpdated, bool>((ref) {
    return isUpdated();
});

class isUpdated extends StateNotifier<bool> {
  isUpdated() : super(false);
  void setUpdate() => state = !state;
}
