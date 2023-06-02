class Salsa {
  final int id;
  final String nombre;

  Salsa({
    required this.id,
    required this.nombre,
  });

  factory Salsa.fromJson(Map<String, dynamic> json) {
    return Salsa(
      id: int.parse(json['id']),
      nombre: json['nombre'],
    );
  }
}