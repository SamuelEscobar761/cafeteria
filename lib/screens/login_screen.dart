import 'package:cafeteria/services/api_connector.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();

  LoginScreen({super.key});

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
        backgroundColor: Color.fromARGB(255, 107, 142, 35),
        centerTitle: true,
        title: Text(
          'Bienvenido a Lalas Coffee',
          style: TextStyle(fontSize: 20.0),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.lightGreen.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 150.0,
                height: 150.0,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: codigoController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: 'Código',
                  filled: true,
                  fillColor: Colors.transparent,
                  focusColor: Colors.green, // Color de resaltado del borde al enfocar
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                  controller: correoController,
                style: TextStyle(
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  filled: true,
                  fillColor: Colors.transparent,
                  focusColor: Colors.green, // Color de resaltado del borde al enfocar
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwdController,
                obscureText: true,
                style: TextStyle(
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.transparent,
                  focusColor: Colors.green, // Color de resaltado del borde al enfocar
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Acción a realizar al presionar el botón de inicio de sesión
                  final codigo = codigoController.text;
                  final correo = correoController.text;
                  final passwd = passwdController.text;

                  ApiConnector.instance.getClient(codigo, correo, passwd).then((cliente) {
                    if (cliente != null) {
                      // El cliente se encontró, puedes realizar alguna acción aquí
                      Navigator.pushNamed(
                        context,
                        '/menu',
                        arguments: codigo, // Pasas el objeto cliente como argumento
                      );
                    } else {
                      // El cliente no se encontró o hubo un error, puedes mostrar un mensaje de error o realizar alguna acción adicional
                      showErrorMessage(context, 'Código, correo o contraseña incorrectos. Por favor, inténtelo nuevamente.');
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 107, 142, 35),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
