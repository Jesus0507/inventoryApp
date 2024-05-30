

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_movil/constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../login/Login.dart';
import 'categorries.dart';
import 'Product.dart';
import 'item_card.dart';



class Inventario extends StatefulWidget {
  final int cantId;
  //Inventario(this.cantId, {super.key});
  const Inventario(this.cantId,{Key? key}):super(key: key);



  @override
  State<Inventario> createState() => _InventarioState();
}

class _InventarioState extends State<Inventario> {

  Future<List<Productos>>productFuture = getProducto();
  Future<List<Categorias>>categoryFuture = getCategory();
  String selectedCategory = '';

  static Future<List<Productos>> getProducto() async {
     //print(cantId);

      final allProducts = [];
      const urlCategories = 'https://joseviveresm.000webhostapp.com/api/categorias';
      final response = await http.get(Uri.parse(urlCategories));
      final body = json.decode(response.body);
      for (int i = 0; i < body.length; i ++) {
          final urlProductsByCategories = 'https://joseviveresm.000webhostapp.com/inventario/listar2/api?opcion=' + body[i]['id'].toString();
          final responseProduct = await http.get(Uri.parse(urlProductsByCategories));
          final bodyProducts = json.decode(responseProduct.body.split('"' + body[i]['id'].toString() +'"')[1]);
          for (int j = 0; j < bodyProducts.length; j++) {
              if (bodyProducts[j]['url_img'] == '' || bodyProducts[j]['url_img'] == null) {
                bodyProducts[j]['url_img'] = 'assets/images/MP.png';
              }
              allProducts.add(bodyProducts[j]);
          
          }
      }
      return allProducts.map<Productos>(Productos.fromJson).toList();
  }

    static Future<List<Categorias>> getCategory() async {
      const urlCategories = 'https://joseviveresm.000webhostapp.com/api/categorias';
      final response = await http.get(Uri.parse(urlCategories));
      final body = json.decode(response.body);
      return body.map<Categorias>(Categorias.fromJson).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market MP'),
        backgroundColor: Color(0xFFA4A4A4),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const ImageIcon(
            AssetImage('assets/images/market_1.png')
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                alerta();
              },
              icon: const Icon(Icons.list,
              ),color: kTextColor
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Inventario",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
                    Container(
            height: 50,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            constraints: const BoxConstraints(minWidth: 230.0, minHeight: 25.0),
            child: Row(children: [Expanded(
              child: FutureBuilder<List<Categorias>>(
              future: categoryFuture,
              builder:(context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      } else if(snapshot.hasData){
                        var categorias = snapshot.data!;
                        return buildCategory(categorias);
                      }else{
                        return const Text('No hay categorias registradas');
                      }
              }
              )
              )]
            ),
          ),
        //  Categories(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: FutureBuilder<List<Productos>>(
                    future: productFuture ,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      } else if(snapshot.hasData){
                        var Productos = snapshot.data!;
                       final filterProducts = Productos.where((product) {
                       return selectedCategory == '' || selectedCategory == product.categoria; 
                       }).toList();
                        return buildProducto(filterProducts);
                      }else{
                        return const Text('No hay productos en el inventario');
                      }
                    },
                ),
              ),
            ),
        ],
      ),
    );
  }
  Widget buildProducto(List<Productos> Productos) => GridView.builder(
    itemCount: Productos.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: kDefaultPaddin,
    crossAxisSpacing: kDefaultPaddin,
    childAspectRatio: 0.75,),
    itemBuilder: (context, index){
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${Productos[index].id}",
                child:  Image.network(Productos[index].url_img),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              Productos[index].nombre+' '+Productos[index].marca,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\Precio: ${Productos[index].precio_venta} bs",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "\Cant:${Productos[index].cantidad}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
    }
  );

    Widget buildCategory(List<Categorias> Categorias) => ListView.builder(
    itemCount: Categorias.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (context, index) => FilterChip(
                selected: selectedCategory == Categorias[index].categoria ? true: false,
                label: Text(Categorias[index].categoria),
                onSelected: (selected) {
                  setState(() {
                    if(selected){
                      selectedCategory = Categorias[index].categoria;
                    }
                    else {
                      selectedCategory = '';
                    }
                  });
                }
              )
  );

  void alerta() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Cerrar sesion'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              ),
              child: const Text('Cerrar'),
            ),
          ],
        ));
  }


}

