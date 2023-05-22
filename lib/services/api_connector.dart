import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Cliente.dart';

class ApiConnector {
  static const String baseUrl = 'http://192.168.1.223/api-cafeteria'; // Reemplaza con la URL de tu servidor

  // Instancia única del singleton
  static final ApiConnector _instance = ApiConnector._internal();

  // Constructor privado
  ApiConnector._internal();

  // Método estático para acceder a la instancia única del singleton
  static ApiConnector get instance => _instance;

  Future<void> realizarConexion() async {
    final url = Uri.parse('$baseUrl/index.php'); // Reemplaza 'tu_endpoint' con el endpoint de tu API
    print(url);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta aquí
        print(response.body);
      } else {
        // La solicitud no fue exitosa, maneja el error aquí
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Ocurrió un error durante la conexión, maneja la excepción aquí
      print('Error de conexión: $e');
    }
  }
  Future<Cliente?> getClient(codigo, correo, passwd) async {
    final url = Uri.parse('$baseUrl/cliente.php');

    final body = {
      'codigo': codigo,
      'correo': correo,
      'passwd': passwd,
    };
    try{
      final response = await http.post(url, body: body).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta aquí
        print(response.body);
        final jsonResponse = jsonDecode(response.body);
        final codigo = jsonResponse['codigo'];
        final nombre = jsonResponse['nombre'];
        final email = jsonResponse['email'];
        final telefono = jsonResponse['telefono'];

        // Crear un objeto basado en los valores obtenidos
        final cliente = Cliente(codigo: codigo, nombre: nombre, email: email, telefono: telefono);
        return cliente;

      } else {
        // La solicitud no fue exitosa, maneja el error aquí
        print('Error en la solicitud: ${response.statusCode}');
      }

    }catch (e) {
      // Ocurrió un error durante la conexión, maneja la excepción aquí
      print('Error de conexión: $e');
    };
    return null;
  }
}


