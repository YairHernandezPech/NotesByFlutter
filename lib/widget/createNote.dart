import 'package:flutter/material.dart';
import 'package:notes/Database/modelNote.dart';
import 'package:notes/widget/components/BubbleWidget.dart';
import 'package:notes/widget/components/CustomTextField.dart';

class Createnote extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final ModelNote modelNote =
      ModelNote(); // Instancia del modelo para interactuar con la base de datos

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BubbleWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                labelText: 'Titulo',
                obscureText: false,
                maxLines: null,
                varianText:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                controller: titleController, // Añadir controlador
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Escriba su nota aquí',
                obscureText: false,
                maxLines: null,
                minLines: 15,
                controller: noteController, // Añadir controlador
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 60, // Altura del botón
                child: ElevatedButton(
                  onPressed: () async {
                    String title = titleController.text;
                    String note = noteController.text;

                    if (title.isNotEmpty && note.isNotEmpty) {
                      await modelNote.create(title, note);
                      titleController.clear();
                      noteController.clear();

                      //ESto es para mostrar un mensaje de éxito
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
                              SizedBox(
                                  width:
                                      12), // Espacio entre el ícono y el texto
                              Expanded(
                                child: Text(
                                  'Nota creada con éxito',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          backgroundColor:
                              const Color.fromARGB(128, 238, 127, 127),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          content: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel, color: Colors.white),
                              SizedBox(
                                  width:
                                      12), // Espacio entre el ícono y el texto
                              Expanded(
                                child: Text(
                                  'Los campos no pueden estar vacíos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(double.infinity, 60), // Ancho completo
                    backgroundColor: const Color.fromARGB(128, 127, 134, 238),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Bordes redondeados
                    ),
                  ),
                  child: const Text(
                    'Guardar',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white), // Estilo del texto
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
