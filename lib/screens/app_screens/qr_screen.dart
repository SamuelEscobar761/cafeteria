import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class QRScreen extends StatelessWidget {
  final String imageUrl = "https://static.vecteezy.com/system/resources/previews/002/557/391/original/qr-code-for-scanning-free-vector.jpg";

  void _downloadImage(String imageUrl) async {
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final directory = await getExternalStorageDirectory();
        final savedDir = directory!.path;
        final taskId = await FlutterDownloader.enqueue(
          url: imageUrl,
          savedDir: savedDir,
          showNotification: true,
          fileName: 'qr_image.jpg',
          openFileFromNotification: true,
        );

        // Guardar la imagen en la galería
        final savedImagePath = '$savedDir/qr_image.jpg';
        final result = await GallerySaver.saveImage(savedImagePath);
        print('Imagen guardada en la galería: $result');
      } else if (status.isDenied) {
        print('Permiso de almacenamiento denegado. Puedes habilitarlo en la configuración de la aplicación.');
      } else if (status.isPermanentlyDenied) {
        print('Permiso de almacenamiento permanentemente denegado. Puedes habilitarlo en la configuración de la aplicación.');
      }
    } catch (e) {
      print('Error al descargar la imagen: $e');
    }
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
