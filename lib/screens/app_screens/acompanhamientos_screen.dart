import 'package:flutter/material.dart';
import '../../models/Almuerzo.dart';

class AcompanhamientosScreen extends StatefulWidget {
  final Almuerzo almuerzo;
  AcompanhamientosScreen({
    Key? key,
    required this.almuerzo,
  }) : super(key: key);

  @override
  _AcompanhamientosScreenState createState() => _AcompanhamientosScreenState();
}

class _AcompanhamientosScreenState extends State<AcompanhamientosScreen> {
  List<String> acompanhamientosDisponibles = [
    'Acompanhamiento 1',
    'Acompanhamiento 2',
    'Acompanhamiento 3',
    'Acompanhamiento 4',
  ];
  List<String> ensaladasDisponibles = [
    'Ensalada 1',
    'Ensalada 2',
    'Ensalada 3',
    'Ensalada 4',
  ];
  String? acompanhamientoSeleccionado;
  String? ensaladaSeleccionada;

  @override
  Widget build(BuildContext context) {
    Almuerzo almuerzo = widget.almuerzo;
    List<String> acompanhamientosSeleccionado = List<String>.filled(almuerzo.acompanhamientos, '');
    List<String> ensaladasSeleccionada = List<String>.filled(almuerzo.ensaladas, 'e');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 142, 35),
        title: Text(almuerzo.nombre),
      ),
      backgroundColor: Colors.lightGreen.shade200,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < almuerzo.acompanhamientos; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Acompañamiento ${i + 1}:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: acompanhamientoSeleccionado,
                    hint: const Text('Seleccione un acompañamiento'),
                    onChanged: (String? newValue) {
                      setState(() {
                        acompanhamientosSeleccionado[i] = newValue!;
                      });
                    },
                    items: acompanhamientosDisponibles.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            for (int i = 0; i < almuerzo.ensaladas; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ensalada ${i + 1}:',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: ensaladaSeleccionada,
                    hint: Text('Seleccione una ensalada'),
                    onChanged: (String? newValue) {
                      setState(() {
                        ensaladasSeleccionada[i] = newValue!;
                      });
                    },
                    items: ensaladasDisponibles.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción a realizar al presionar el botón de finalizar
          // Puedes utilizar las variables acompanhamientoSeleccionado y ensaladaSeleccionada
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
