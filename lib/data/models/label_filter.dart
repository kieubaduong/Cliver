class LabelFilter {
  String text;

  LabelFilter({required this.text});

  static getListLabel() {
    return [
      LabelFilter(text: 'Follow-up'),
      LabelFilter(text: 'Nudge'),
    ].toList();
  }
}
