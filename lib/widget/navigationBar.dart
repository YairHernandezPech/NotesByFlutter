import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart'; // Para los íconos

class BottomNavigation extends StatefulWidget {
  final Function(int) onPageChange;
  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey;

  BottomNavigation({required this.onPageChange, required this.bottomNavigationKey});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _pageIndex = 0; // Cambiado de 0 a 1 para que el botón del medio esté seleccionado

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: widget.bottomNavigationKey,
      index: _pageIndex, // Establecer el índice inicial
      items: const <Widget>[
        Icon(CupertinoIcons.folder_open, size: 30, color: Colors.white),
        Icon(CupertinoIcons.add, size: 30, color: Colors.white),
        Icon(CupertinoIcons.calendar_today, size: 30, color: Colors.white),
      ],
      color: Color.fromARGB(128, 112, 121, 241),
      buttonBackgroundColor: Color.fromARGB(128, 112, 121, 241),
      backgroundColor: Color.fromARGB(255, 251, 248, 251),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      onTap: (index) {
        setState(() {
          _pageIndex = index;
        });

        widget.onPageChange(index); // Llama a la función callback cuando cambie de página

        // if (index == 1) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => Createnote()),
        //   );
        // }
      },
      letIndexChange: (index) => true,
    );
  }
}
