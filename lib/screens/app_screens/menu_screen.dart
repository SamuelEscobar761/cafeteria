import 'package:flutter/material.dart';

import '../../models/Almuerzo.dart';
import '../constants.dart';
import 'acompanhamientos_screen.dart';

class MenuScreen extends StatelessWidget {
  final List<Almuerzo> almuerzos = [
    Almuerzo(
      nombre: "Almuerzo 1",
      descripcion: "Descripción del almuerzo 1",
      precio: 10.99,
      imagen: "assets/images/upb_logo.jpg",
      acompanhamientos: 2,
      ensaladas: 1,
    ),
    Almuerzo(
      nombre: "Almuerzo 2",
      descripcion: "Descripción del almuerzo 2",
      precio: 9.99,
      imagen: "assets/images/upb_logo.jpg",
      acompanhamientos: 1,
      ensaladas: 2,
    ),
    // Agrega más objetos Almuerzo según tus necesidades
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 142, 35),
        centerTitle: true,
        title: Text(
          '¿Que vas a comer hoy?',
          style: TextStyle(fontSize: 20.0),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.lightGreen.shade200,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Nuestro menu de hoy:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: almuerzos.length,
              itemBuilder: (context, index) {
                Almuerzo almuerzo = almuerzos[index];
                EdgeInsets margin = index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.0);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcompanhamientosScreen(almuerzo: almuerzo),
                      ),
                    );
                  },
                  child: Container(
                    margin: margin,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset(almuerzo.imagen),
                      title: Text(almuerzo.nombre),
                      subtitle: Text(almuerzo.descripcion),
                      trailing: Text("Bs. ${almuerzo.precio.toStringAsFixed(2)}"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}