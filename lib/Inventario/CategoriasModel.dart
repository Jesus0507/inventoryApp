class Categorias {
  final int id;
  final String categoria;


  const Categorias({
    required this.id,
    required this.categoria
  });

  static Categorias fromJson(json) => Categorias(
    id: json['id'],
    categoria : json['categoria'],
  );
}