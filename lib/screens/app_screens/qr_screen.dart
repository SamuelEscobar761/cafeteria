import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';


class QRScreen extends StatelessWidget {
  final String imageUrl = "https://static.vecteezy.com/system/resources/previews/002/557/391/original/qr-code-for-scanning-free-vector.jpg";

  Future<bool?> _downloadImage(String imageUrl) async {
    bool? success = await GallerySaver.saveImage(imageUrl);
    return success;
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
            ElevatedButton(
              onPressed: () async {
                bool? downloadSuccess = await _downloadImage(imageUrl);
                if (downloadSuccess != null && downloadSuccess) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Descarga exitosa'),
                        content: Text('La imagen se descargó correctamente.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Mostrar un mensaje de error si la descarga no fue exitosa
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('No se pudo descargar la imagen.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
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

