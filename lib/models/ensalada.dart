class Ensalada {
  final int id;
  final String nombre;

  Ensalada({
    required this.id,
    required this.nombre,
  });

  factory Ensalada.fromJson(Map<String, dynamic> json) {
    return Ensalada(
      id: int.parse(json['id']),
      nombre: json['nombre'],
    );
  }
}