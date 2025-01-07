class Note {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt});

  // Método para convertir un Map en un objeto Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['note_id'],
      title: map['title'],
      content: map['note'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
