import 'package:flutter/material.dart';
import 'package:notes/Database/modelNote.dart';
import 'package:notes/widget/editNote.dart';

class CardScrollView extends StatefulWidget {
  @override
  _CardScrollViewState createState() => _CardScrollViewState();
}

class _CardScrollViewState extends State<CardScrollView> {
  List<Map<String, dynamic>> _notes = [];
  final ModelNote _modelNote = ModelNote();
  TextEditingController _searchController =
      TextEditingController(); // Controlador del TextField

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _searchController.addListener(
        _onSearchChanged); // Escuchar cambios en el campo de búsqueda
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Cargar todas las notas inicialmente
  Future<void> _loadNotes() async {
    final notes = await _modelNote.findAll();
    setState(() {
      _notes = notes;
    });
  }

  // Función de búsqueda que se llama cada vez que cambia el texto en el TextField
  void _onSearchChanged() async {
    if (_searchController.text.isEmpty) {
      _loadNotes(); // Si no hay texto, carga todas las notas
    } else {
      final filteredNotes = await _modelNote.filter(_searchController.text);
      setState(() {
        _notes = filteredNotes; // Actualizar las notas con las filtradas
      });
    }
  }

  Future<void> _deleteNote(int noteId) async {
    await _modelNote.delete(noteId); // Llamada para eliminar la nota
    _loadNotes(); // Recargar las notas después de eliminar
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller:
                  _searchController, // Asignar el controlador al TextField
              decoration: InputDecoration(
                hintText: 'Buscar notas...',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Expanded(
          child: _notes.isEmpty
              ? Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 253, 212, 226)
                          .withOpacity(0.2), // Color rosado con opacidad baja
                      BlendMode.srcATop, // Modo de mezcla
                    ),
                    child: Image.asset(
                      'assets/note.gif', // Ruta de tu imagen
                      width: 200, // Tamaño de la imagen
                      height: 200,
                      fit: BoxFit.contain, // Ajuste de la imagen
                    ),
                  ),
                )
              : ListWheelScrollView(
                  itemExtent: 100,
                  diameterRatio: 2.5,
                  physics: FixedExtentScrollPhysics(),
                  children: List.generate(
                    _notes.length,
                    (index) => _buildDismissibleCard(_notes[index]),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildDismissibleCard(Map<String, dynamic> note) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        // Mostrar un diálogo de confirmación
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // Bordes redondeados
              ),
              title: Row(
                children: [
                  Icon(Icons.warning_rounded,
                      color: Colors.redAccent), // Ícono de advertencia
                  SizedBox(width: 10),
                  Text(
                    'Confirmar eliminación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent, // Color de texto
                    ),
                  ),
                ],
              ),
              content: Text(
                '¿Estás seguro de que deseas eliminar esta nota?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // No elimina la nota
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.grey, // Botón con color gris para cancelar
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Elimina la nota
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.redAccent, // Color de fondo rojo para eliminar
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(0), // Bordes redondeados
                    ),
                  ),
                  child: Text(
                    'Eliminar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // Texto blanco
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        _deleteNote(note['note_id']); // Eliminar la nota si se confirma
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: const Color.fromARGB(128, 238, 127, 127),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cancel, color: Colors.white),
                SizedBox(width: 12), // Espacio entre el ícono y el texto
                Expanded(
                  child: Text(
                    'Nota Eliminada',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      background: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Editnote(noteId: note['note_id']),
            ),
          );
          if (result == true) {
            _loadNotes();
          }
        },
        child: _buildCard(note),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> note) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Color.fromARGB(128, 127, 134, 238),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    note['title'] ?? 'Sin título',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.push_pin,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  // El texto de la nota a la izquierda con ajuste
                  Expanded(
                    child: Text(
                      note['note'] ?? 'Sin título',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1, // Limita a una línea
                      overflow:
                          TextOverflow.ellipsis, // Corta el texto con "..."
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre el texto y la fecha
                  // El texto de la fecha a la derecha
                  Text(
                    note['created_at'] ?? 'Sin fecha',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
