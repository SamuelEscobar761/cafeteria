class Almuerzo {
  final int id;
  final String nombre;
  final bool paraLlevar;
  final String descripcion;
  final double precio;
  final String imagen;
  final int guarniciones;
  final int ensaladas;
  final int salsas;

  Almuerzo({
    required this.id,
    required this.nombre,
    required this.paraLlevar,
    required this.descripcion,
    required this.precio,
    required this.imagen,
    required this.guarniciones,
    required this.ensaladas,
    required this.salsas,
  });

  factory Almuerzo.fromJson(Map<String, dynamic> json) {
    return Almuerzo(
      id: int.parse(json['id']),
      nombre: json['nombre'],
      paraLlevar: json['para_llevar'] == "1",
      descripcion: json['descripcion'],
      precio: double.parse(json['precio']),
      imagen: json['imagen'],
      guarniciones: int.parse(json['guarniciones']),
      ensaladas: int.parse(json['ensaladas']),
      salsas: int.parse(json['salsas']),
    );
  }
}