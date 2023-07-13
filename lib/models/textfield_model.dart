class TextfieldModel {
  final String text;
  final int position;

  const TextfieldModel({required this.text, required this.position});

  static TextfieldModel initial() =>
      const TextfieldModel(text: '', position: 0);
}
