class Ingresos {
  final int id;
  final String fecha;
  final String hora;
  final String total;
  final String nombre;
  final String vendedor;

  const Ingresos({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.total,
    required this.nombre,
    required this.vendedor,
  });

  static Ingresos fromJson(json) => Ingresos(
    id: json['id'],
    nombre : json['nombre'],
    fecha :json['fecha'],
    hora :json['hora'],
    total:json['total'],
    vendedor: json['vendedor'],
  );
}

class Egresos {
  final int id;
  final String fecha;
  final String hora;
  final String total;
  final String nombre;
  final String vendedor;

  const Egresos({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.total,
    required this.nombre,
    required this.vendedor,
  });

  static Egresos fromJson(json) => Egresos(
    id: json['id'],
    nombre : json['nombre'],
    fecha :json['fecha'],
    hora :json['hora'],
    total:json['total'],
    vendedor: json['vendedor'],
  );
}

class Ventas {
  final String ventas;
  final String gastos;

  const Ventas({
    required this.ventas,
    required this.gastos
  });

  static Ventas fromJson(json) => Ventas(
    ventas : json['ventas'],
    gastos: json['gastos']
  );
}