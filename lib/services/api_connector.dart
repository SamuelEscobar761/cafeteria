import 'package:http/http.dart' as http;

class ApiConnector {
  static const String baseUrl = 'http://192.168.55.83'; // Reemplaza con la URL de tu servidor

  Future<void> realizarConexion() async {
    final url = Uri.parse('$baseUrl/api-cafeteria/'); // Reemplaza 'tu_endpoint' con el endpoint de tu API
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
}

