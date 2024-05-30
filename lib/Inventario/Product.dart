
class Productos {
  final int id;
  final String nombre;
  final String url_img;
  final String marca;
  final num precio_venta;
  final int cantidad;
  final String categoria;

  const Productos({
    required this.id,
    required this.nombre,
    required this.url_img,
    required this.marca,
    required this.precio_venta,
    required this.cantidad,
    required this.categoria,
  });

  static Productos fromJson(json) => Productos(
    id: json['id'],
    nombre : json['nombre'],
    url_img : 'https://joseviveresm.000webhostapp.com/'+json['url_img'],
    marca :json['marca'],
    precio_venta:json['precio_venta'],
    cantidad: json['cantidad'],
    categoria: json['categoria']
  );
}