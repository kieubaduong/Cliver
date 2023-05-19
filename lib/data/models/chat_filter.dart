import 'package:flutter/material.dart';

class ChatFilter {
  IconData icon;
  String text;

  ChatFilter({
    required this.icon,
    required this.text,
  });

  static List<ChatFilter> getListChatFilter() {
    return [
      ChatFilter(
        icon: Icons.all_inbox_outlined,
        text: 'All',
      ),
      ChatFilter(
        icon: Icons.mail_outline,
        text: 'Unread',
      ),
      ChatFilter(
        icon: Icons.block,
        text: 'Spam',
      ),
    ].toList();
  }
}
