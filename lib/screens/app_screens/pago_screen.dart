import 'package:flutter/material.dart';
import 'menu_screen.dart';

class PagoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 142, 35),
        title: Text(
          'Pagar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.lightGreen.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/qr.png', width: 200, height: 200),
            SizedBox(height: 16),
            Text(
              'Escanee el código QR para pagar',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción para descargar el código QR
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 107, 142, 35),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Descargar QR',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 32),
            Text(
              '¡Gracias por su compra!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 107, 142, 35),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()), // Navegar a MenuScreen
          );
        },
        child: Icon(Icons.home),
        backgroundColor: Color.fromARGB(255, 107, 142, 35),
      ),
    );
  }
}
