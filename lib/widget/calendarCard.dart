import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:notes/Database/modelNote.dart';
import 'package:notes/Database/note.dart';

class CalendarCard extends StatefulWidget {
  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final ModelNote _modelNote = ModelNote();
  List<Note> _notes = []; // Lista para almacenar notas

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Cargar notas al iniciar
  }

  Future<void> _fetchNotes() async {
    List<Map<String, dynamic>> notesMap = await _modelNote.findAll();
    setState(() {
      _notes = notesMap.map((noteMap) => Note.fromMap(noteMap)).toList();
    });
  }

  List<Note> get _filteredNotes {
    return _notes
        .where((note) =>
            note.createdAt.year == _selectedDay.year &&
            note.createdAt.month == _selectedDay.month &&
            note.createdAt.day == _selectedDay.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
                                scrollDirection: Axis
                            .vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calendario',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color:
                    Color.fromARGB(221, 41, 41, 41), // Color más suave
              ),
            ),
            SizedBox(height: 16),
            // ListView horizontal para mostrar los cuadrados con notas
            Container(
              height: 70, // Altura del ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                itemCount: _filteredNotes.length, // Número de notas filtradas
                itemBuilder: (context, index) {
                  final note =
                      _filteredNotes[index]; // Obtener la nota correspondiente
                  return Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0), // Espacio entre tarjetas
                    child: Container(
                      width: 100, // Ancho del cuadrado
                      height: 50, // Altura del cuadrado
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            128, 112, 121, 241), // Color azul profesional
                        borderRadius:
                            BorderRadius.circular(16), // Bordes redondeados
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4), // Sombra más suave
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ajustar texto para que respete el tamaño de la tarjeta
                            Text(
                              note.title.length > 5
                                  ? note.title.substring(
                                      0, 5) // Limitar el título a 5 caracteres
                                  : note.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold, // Negrita para mayor énfasis
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Asegura que el texto no desborde
                              maxLines: 1, // Limitar a una línea
                            ),
                            SizedBox(
                                height:
                                    4), // Espacio entre el título y el contenido
                            Text(
                              note.content.length > 10
                                  ? note.content.substring(0, 10) +
                                      '...' // Limitar contenido a 10 caracteres
                                  : note.content,
                              style: TextStyle(
                                color: Colors
                                    .white70, // Color más suave para el contenido
                                fontSize: 14,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Asegura que el texto no desborde
                              maxLines: 1, // Limitar a una línea
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            // Calendario
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // actualizar el día enfocado
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF4A90E2),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Tarjetas adicionales
            Text(
              'Atajos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tarjeta con icono de papelera
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.45, // Ancho relativo a la pantalla
                  height: 140, // Altura de la tarjeta
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        124, 167, 0, 0), // Color de la tarjeta
                    borderRadius: BorderRadius.circular(16), // Bordes redondeados
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4), // Sombra más suave
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Papelera', // Título de la tarjeta de papelera
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'No hay notas deshechadas', // Descripción de ejemplo
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(), // Espacio para empujar el icono hacia abajo
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.delete,
                              color: Colors.white), // Icono de papelera
                        ),
                      ],
                    ),
                  ),
                ),
                // Tarjeta con icono de configuración
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.45, // Ancho relativo a la pantalla
                  height: 140, // Altura de la tarjeta
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        132, 0, 126, 0), // Color de la tarjeta
                    borderRadius: BorderRadius.circular(16), // Bordes redondeados
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4), // Sombra más suave
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Configuración', // Título de la tarjeta de configuración
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Configuraciones', // Descripción de ejemplo
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(), // Espacio para empujar el icono hacia abajo
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.settings,
                              color: Colors.white), // Icono de configuración
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
