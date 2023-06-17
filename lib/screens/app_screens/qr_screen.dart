import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';


class QRScreen extends StatelessWidget {
  final String imageUrl = "https://static.vecteezy.com/system/resources/previews/002/557/391/original/qr-code-for-scanning-free-vector.jpg";

  void _downloadImage(String imageUrl) async {
    GallerySaver.saveImage(imageUrl);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              width: 200, // Ancho deseado de la imagen
              height: 200, // Alto deseado de la imagen
            ),
            SizedBox(height: 16.0),
            ElevatedButton (
              onPressed: () {
                // Lógica para descargar la imagen
                _downloadImage(imageUrl);
              },
              child: Text('Descargar imagen'),
            ),
            ElevatedButton (
              onPressed: () {
                // Lógica para compartir la imagen en redes sociales
              },
              child: Text('Compartir imagen'),
            ),
            ElevatedButton (
              onPressed: () {
                // Lógica para finalizar la reserva
              },
              child: Text('Finalizar reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
