import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/widget/calendarCard.dart';
import 'package:notes/widget/card.dart';
import 'package:notes/widget/createNote.dart';
import 'package:notes/widget/navigationBar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pageIndex =
      0; // Cambiado de 0 a 1 para seleccionar el botón del medio al inicio
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void _onPageChange(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  List<Widget> _listBodies = [CardScrollView(), Createnote(), CalendarCard()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Text("Notas"),
      ),
      body: _listBodies[_pageIndex],
      bottomNavigationBar: BottomNavigation(
        onPageChange: _onPageChange,
        bottomNavigationKey: _bottomNavigationKey,
      ),
    );
  }
}
