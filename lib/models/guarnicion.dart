class Guarnicion {
  final int id;
  final String nombre;

  Guarnicion({
    required this.id,
    required this.nombre,
  });

  factory Guarnicion.fromJson(Map<String, dynamic> json) {
    return Guarnicion(
      id: int.parse(json['id']),
      nombre: json['nombre'],
    );
  }
}