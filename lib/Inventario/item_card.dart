// import 'package:flutter/material.dart';
// import 'Product.dart';
//
// import '../../../constants.dart';
//
// class ItemCard extends StatelessWidget {
//
//
//
//   List<Datos_Productos> data = <Datos_Productos>[];
//
//   Future<List<Datos_Productos>> tomar_datos () async{
//
//     var url = 'http://localhost/joseViveres/inventario/listar?api=1';
//     var response = await http.post(Uri.parse(url));
//     var datos = jsonDecode(response.body);
//     var registros = <Datos_Productos>[];
//     for (datos in datos) {
//       registros.add(Datos_Productos.fromJson(datos));
//     }
//
//     return registros;
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     tomar_datos().then((value){
//       setState(() {
//         data.addAll(value);
//       });
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(kDefaultPaddin),
//               decoration: BoxDecoration(
//                 color: product.color,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Hero(
//                 tag: "${product.id}",
//                 child: Image.asset(product.image),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
//             child: Text(
//               // products is out demo list
//               product.title,
//               style: TextStyle(color: kTextLightColor),
//             ),
//           ),
//           Text(
//             "\$${product.price}",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           )
//         ],
//       ),
//     );
//   }
// }
