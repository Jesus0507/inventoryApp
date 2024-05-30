class CuentasDeudas {
  final int id;
  final String suma;
  final num cant;
  final String nombre;
  final String total;

  const CuentasDeudas({
    required this.id,
    required this.suma,
    required this.cant,
    required this.nombre,
    required this.total
  });

  static CuentasDeudas fromJson(json) => CuentasDeudas(
    id: json['id'],
    suma: json['suma'],
    cant: json['cant'],
    nombre: json['nombre'],
    total: json['total']
  );
}