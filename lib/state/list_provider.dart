import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat.dart';

List<Chat> chattingList = [];

final listStateProvider = StateNotifierProvider<ListNotifier, List<Chat>>(
  (ref) => ListNotifier(),
);

class ListNotifier extends StateNotifier<List<Chat>> {
  ListNotifier() : super(chattingList);
  void addItem(Chat chat) {
    state.add(chat);
  }
}
