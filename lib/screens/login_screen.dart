import 'package:cafeteria/services/api_connector.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: codigoController,
              decoration: InputDecoration(
                labelText: 'Código',
              ),
            ),
            TextField(
              controller: correoController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            TextField(
              controller: passwdController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final codigo = codigoController.text;
                final correo = correoController.text;
                final passwd = passwdController.text;

                ApiConnector.instance.getClient(codigo, correo, passwd).then((cliente) {
                  if (cliente != null) {
                    // El cliente se encontró, puedes realizar alguna acción aquí
                    Navigator.pushNamed(
                      context,
                      '/menu',
                      arguments: cliente, // Pasas el objeto cliente como argumento
                    );
                  } else {
                    // El cliente no se encontró o hubo un error, puedes mostrar un mensaje de error o realizar alguna acción adicional
                    showErrorMessage(context, 'Código, correo o contraseña incorrectos. Por favor, inténtelo nuevamente.');
                  }
                });
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

