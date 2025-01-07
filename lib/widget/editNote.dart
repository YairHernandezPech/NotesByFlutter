import 'package:flutter/material.dart';
import 'package:notes/Database/modelNote.dart';
import 'package:notes/widget/components/BubbleWidget.dart';
import 'package:notes/widget/components/CustomTextField.dart';

class Editnote extends StatefulWidget {
  final int noteId;

  Editnote({required this.noteId});

  @override
  _EditnoteState createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final ModelNote modelNote = ModelNote();

  @override
  void initState() {
    super.initState();
    _loadNoteData();
  }

  Future<void> _loadNoteData() async {
    // Cargar la nota utilizando el noteId
    List<Map<String, dynamic>> noteData = await modelNote.findByID(widget.noteId);

    if (noteData.isNotEmpty) {
      setState(() {
        // Asignar los valores a los controladores
        titleController.text = noteData[0]['title'];
        noteController.text = noteData[0]['note'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Nota'),
        backgroundColor: Color.fromARGB(128, 127, 134, 238),
      ),
      body: Stack(
        children: [
          BubbleWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Titulo',
                  obscureText: false,
                  maxLines: null,
                  varianText: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  controller: titleController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Escriba su nota aquí',
                  obscureText: false,
                  maxLines: null,
                  minLines: 20,
                  controller: noteController,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      String title = titleController.text;
                      String note = noteController.text;

                      if (title.isNotEmpty && note.isNotEmpty) {
                        await modelNote.update(widget.noteId, title, note);
                        titleController.clear();
                        noteController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            backgroundColor:
                                const Color.fromARGB(128, 127, 134, 238),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            content: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Nota actualizada con éxito',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        Navigator.pop(context, true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                      backgroundColor: const Color.fromARGB(128, 127, 134, 238),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
