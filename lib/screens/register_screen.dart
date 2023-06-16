import 'package:cafeteria/services/api_connector.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isValidEmail(String email) {
    // Expresión regular para validar el formato del correo electrónico
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegExp.hasMatch(email);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce un nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Código',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce un código';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce un correo electrónico';
                    }
                    if (!isValidEmail(value)) {
                      return 'Por favor, introduce un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce una contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Verificar Contraseña',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, verifica tu contraseña';
                    }
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Acción a realizar al presionar el botón de registro
                      final nombre = nombreController.text;
                      final codigo = codigoController.text;
                      final correo = correoController.text;
                      final telefono = telefonoController.text;
                      final passwd = _passwordController.text;
                      if (_formKey.currentState!.validate()) {
                      ApiConnector.instance.registrarCliente(nombre, codigo, correo, telefono, passwd);
                      Navigator.pushNamed(context, '/menu');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 107, 142, 35),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Registrarse'),
                ),
              ],
            ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: codigoController,
                decoration: const InputDecoration(
                  labelText: 'Código',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce un código';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce un correo electrónico';
                  }
                  if (!isValidEmail(value)) {
                    return 'Por favor, introduce un correo electrónico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Telefono (opcional)',
                ),
              ),
              const SizedBox(height: 16.0,),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce una contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Verificar Contraseña',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, verifica tu contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final nombre = nombreController.text;
                  final codigo = codigoController.text;
                  final correo = correoController.text;
                  final telefono = telefonoController.text;
                  final passwd = _passwordController.text;
                  if (_formKey.currentState!.validate()) {
                    // Acción a realizar al presionar el botón de registro
                    ApiConnector.instance.registrarCliente(nombre, codigo, correo, telefono, passwd);
                    Navigator.pushNamed(context, '/menu');
                  }
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
    bool isValidEmail(String email) {
    // Expresión regular para validar el formato del correo electrónico
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegExp.hasMatch(email);
    }
  }
}
