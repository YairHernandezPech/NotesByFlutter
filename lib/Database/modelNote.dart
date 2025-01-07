import 'package:notes/Database/dbConfig.dart';

class ModelNote {
  final DBConfig _dbConfig = DBConfig();

  // Crear una nota
  Future<int> create(String title, String note) async {
    final db = await _dbConfig.database;
    return await db.insert('Notes', {
      'title': title,
      'note': note,
    });
  }

  // Filters by Id, Title, or CreatedAt
  Future<List<Map<String, dynamic>>> filter(String filter) async {
    final db = await _dbConfig.database;
    return await db.query('Notes',
        where: 'title LIKE ? OR note LIKE ? OR created_at LIKE ? ',
        whereArgs: ['%$filter%', '%$filter%', '%$filter%']);
  }

  Future<List<Map<String, dynamic>>> findByID(int noteId) async {
    final db = await _dbConfig.database;
    return await db.query(
      'Notes',
      where: 'note_id = ?', // Filtra por ID
      whereArgs: [noteId], // Argumentos para el filtro
    );
  }

  // Obtener todas las notas
  Future<List<Map<String, dynamic>>> findAll() async {
    final db = await _dbConfig.database;
    return await db.query('Notes');
  }

  // Actualizar una nota
  Future<int> update(int noteId, String title, String note) async {
    final db = await _dbConfig.database;
    return await db.update(
        'Notes',
        {
          'title': title,
          'note': note,
        },
        where: 'note_id = ?',
        whereArgs: [noteId]);
  }

  // Eliminar una nota
  Future<int> delete(int noteId) async {
    final db = await _dbConfig.database;
    return await db.delete('Notes', where: 'note_id = ?', whereArgs: [noteId]);
  }
}
