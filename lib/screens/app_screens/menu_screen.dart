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
    Almuerzo(
      nombre: "Almuerzo 3",
      descripcion: "Descripción del almuerzo 3",
      precio: 12.49,
      imagen: "assets/images/upb_logo.jpg",
      acompanhamientos: 2,
      ensaladas: 1,
    ),
    Almuerzo(
      nombre: "Almuerzo 4",
      descripcion: "Descripción del almuerzo 4",
      precio: 8.99,
      imagen: "assets/images/upb_logo.jpg",
      acompanhamientos: 1,
      ensaladas: 1,
    ),
    Almuerzo(
      nombre: "Almuerzo 5",
      descripcion: "Descripción del almuerzo 5",
      precio: 11.99,
      imagen: "assets/images/upb_logo.jpg",
      acompanhamientos: 2,
      ensaladas: 2,
    ),
    Almuerzo(
      nombre: "Almuerzo 6",
      descripcion: "Descripción del almuerzo 6",
      precio: 9.49,
      imagen: "assets/images/upb_logo.jpg",
      acompanhamientos: 1,
      ensaladas: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 142, 35),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 24, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '¿Qué vas a comer hoy?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
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
              'Nuestro menú de hoy:',
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
                        builder: (context) => AcompanhamientosScreen(
                          almuerzo: almuerzo,
                          ensaladasSeleccionadas: [], // Lista vacía
                          acompanhamientosSeleccionados: [], // Lista vacía
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: margin,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          almuerzo.imagen,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        almuerzo.nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        almuerzo.descripcion,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      trailing: Text(
                        "Bs. ${almuerzo.precio.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
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