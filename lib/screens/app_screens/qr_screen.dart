import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final String imageUrl =
      "https://static.vecteezy.com/system/resources/previews/002/557/391/original/qr-code-for-scanning-free-vector.jpg";

  bool _storagePermissionGranted = false;

  @override
  void initState() {
    super.initState();
    checkStoragePermission();
  }

  void checkStoragePermission() async {
    final status = await Permission.storage.status;
    setState(() {
      _storagePermissionGranted = status.isGranted;
    });
  }

  void requestStoragePermission() async {
    final status = await Permission.storage.request();
    setState(() {
      _storagePermissionGranted = status.isGranted;
    });
  }



  Future<String> _getSavePath() async {
    final directory = await getExternalStorageDirectory();
    final savedDir = directory!.path;
    final savePath = '$savedDir/Android/data/com.example.cafeteria/files/QRImages';
    final directoryExists = await Directory(savePath).exists();
    if (!directoryExists) {
      await Directory(savePath).create(recursive: true);
    }
    return savePath;
  }


  void _downloadImage(String imageUrl) async {
    try {
      if (!_storagePermissionGranted) {
        final status = await Permission.storage.request();
        if (status.isGranted) {
          _storagePermissionGranted = true;
        } else if (status.isPermanentlyDenied) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Permisos de almacenamiento requeridos'),
              content: Text('Esta aplicación necesita acceder al almacenamiento para descargar y guardar la imagen. Por favor, habilita los permisos en la configuración de la aplicación.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    openAppSettings();
                  },
                  child: Text('Abrir configuración'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          );
          return;
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Permisos de almacenamiento requeridos'),
              content: Text('Esta aplicación necesita acceder al almacenamiento para descargar y guardar la imagen.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    requestStoragePermission();
                  },
                  child: Text('Aceptar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          );
          return;
        }
      }

      final savePath = await _getSavePath();
      final taskId = await FlutterDownloader.enqueue(
        url: imageUrl,
        savedDir: savePath,
        showNotification: true,
        fileName: 'qr_image.jpg',
        openFileFromNotification: true,
      );

      final savedImagePath = '$savePath/qr_image.jpg';
      final result = await GallerySaver.saveImage(savedImagePath);
      print('Imagen guardada en la galería: $result');
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
            ElevatedButton(
              onPressed: () {
                // Lógica para descargar la imagen
                _downloadImage(imageUrl);
              },
              child: Text('Descargar imagen'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para compartir la imagen en redes sociales
              },
              child: Text('Compartir imagen'),
            ),
            ElevatedButton(
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
