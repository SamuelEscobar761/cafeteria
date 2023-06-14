import 'package:flutter/material.dart';
import '../../models/Almuerzo.dart';
import 'pago_screen.dart';
import 'dart:math';


class AcompanhamientosScreen extends StatefulWidget {
  final Almuerzo almuerzo;
  final List<String?> acompanhamientosSeleccionados;
  final List<String?> ensaladasSeleccionadas;

  AcompanhamientosScreen({
    Key? key,
    required this.almuerzo,
    required this.acompanhamientosSeleccionados,
    required this.ensaladasSeleccionadas,
  }) : super(key: key);

  @override
  _AcompanhamientosScreenState createState() => _AcompanhamientosScreenState();
}

class _AcompanhamientosScreenState extends State<AcompanhamientosScreen> {
  Random random = Random();
  List<String?> acompanhamientos1Options = ['Opción 1', 'Opción 2', 'Opción 3'];
  List<String?> acompanhamientos2Options = ['Opción A', 'Opción B', 'Opción C'];
  List<String?> ensaladasOptions = ['Ensalada X', 'Ensalada Y', 'Ensalada Z'];
  String? selectedAcompanhamiento1;
  String? selectedAcompanhamiento2;
  String? selectedEnsalada;
  bool isParaLlevar = false;

  @override
  Widget build(BuildContext context) {
    Almuerzo almuerzo = widget.almuerzo;
    List<String?> acompanhamientosSeleccionados = widget.acompanhamientosSeleccionados;
    List<String?> ensaladasSeleccionadas = widget.ensaladasSeleccionadas;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 142, 35),
        title: Text(
          almuerzo.nombre,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.lightGreen.shade200,
      body: Padding(
        padding: EdgeInsets.only(bottom: 72),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Acompañamientos:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              DropdownButton<String?>(
                value: selectedAcompanhamiento1,
                onChanged: (newValue) {
                  setState(() {
                    selectedAcompanhamiento1 = newValue;
                  });
                },
                items: acompanhamientos1Options.map((option) {
                  return DropdownMenuItem<String?>(
                    value: option,
                    child: Text(option ?? 'No seleccionado'),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              DropdownButton<String?>(
                value: selectedAcompanhamiento2,
                onChanged: (newValue) {
                  setState(() {
                    selectedAcompanhamiento2 = newValue;
                  });
                },
                items: acompanhamientos2Options.map((option) {
                  return DropdownMenuItem<String?>(
                    value: option,
                    child: Text(option ?? 'No seleccionado'),
                  );
                }).toList(),
              ),
              SizedBox(height: 32),
              Text(
                'Ensaladas:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              DropdownButton<String?>(
                value: selectedEnsalada,
                onChanged: (newValue) {
                  setState(() {
                    selectedEnsalada = newValue;
                  });
                },
                items: ensaladasOptions.map((option) {
                  return DropdownMenuItem<String?>(
                    value: option,
                    child: Text(option ?? 'No seleccionada'),
                  );
                }).toList(),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Checkbox(
                    value: isParaLlevar,
                    onChanged: (newValue) {
                      setState(() {
                        isParaLlevar = newValue ?? false;
                      });
                    },
                  ),
                  Text(
                    'Para llevar',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: 'button1_${random.nextInt(1000)}',
            onPressed: _clearSelections,
            child: Icon(Icons.delete),
            backgroundColor: Color.fromARGB(255, 107, 142, 35),
            mini: false,
          ),
          FloatingActionButton(
            heroTag: 'button2_${random.nextInt(1000)}',
            onPressed: _onFinalizeButtonPressed,
            child: Icon(Icons.fastfood_rounded),
            backgroundColor: Color.fromARGB(255, 107, 142, 35),
            mini: false,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onFinalizeButtonPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resumen del pedido'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Almuerzo: ${widget.almuerzo.nombre}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Acompañamientos:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('- Acompañamiento 1: ${selectedAcompanhamiento1 ?? "No seleccionado"}', style: TextStyle(fontSize: 16)),
                Text('- Acompañamiento 2: ${selectedAcompanhamiento2 ?? "No seleccionado"}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('Ensaladas:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('- Ensalada: ${selectedEnsalada ?? "No seleccionada"}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('Pedido para llevar: ${isParaLlevar ? "Sí" : "No"}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PagoScreen()), // Navegar a PaymentScreen
                );
              },
              child: Text('Ir a pagar', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  void _clearSelections() {
    setState(() {
      selectedAcompanhamiento1 = null;
      selectedAcompanhamiento2 = null;
      selectedEnsalada = null;
      isParaLlevar = false;
    });
  }
}
