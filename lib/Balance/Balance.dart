import 'package:flutter/material.dart';
import 'package:app_movil/constants.dart';
import '../login/Login.dart';
import 'todo.dart';
import 'colors.dart';
import 'todo_item.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Balance extends StatefulWidget {
  Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {

  Future<List<Ingresos>>productFuture = getIngresos();

  static Future<List<Ingresos>> getIngresos() async {

    const url = 'https://joseviveresm.000webhostapp.com/api/balanceIngresos';
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

      return body?.map<Ingresos>(Ingresos.fromJson).toList();


  }

  Future<List<Egresos>>egresosFuture = getEgresos();

  static Future<List<Egresos>> getEgresos() async {

    const url = 'https://joseviveresm.000webhostapp.com/api/BalanceEgresos';
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body.map<Egresos>(Egresos.fromJson).toList();


  }

  Future<List<Ventas>>VentasFuture = getVentas();

  static Future<List<Ventas>> getVentas() async {

    const url = 'https://joseviveresm.000webhostapp.com/api/ventas';
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body.map<Ventas>(Ventas.fromJson).toList();

  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child:Scaffold(
      backgroundColor: tdBGColor,
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
        bottom: const TabBar(
          tabs: <Widget>[
            Tab(
              text: 'Ventas',
            ),
            Tab(
              text: 'Gastos',
            ),

          ],
        ),
      ),

      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),

                Expanded(
                  child:TabBarView(
                    children: [ FutureBuilder<List<Ingresos>>(
                      future: productFuture ,
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }else if(snapshot.hasError){
                          return Text('${snapshot.error}');
                        } else if(snapshot.hasData){
                          final Ingresos = snapshot.data!;
                          return buildIngresos(Ingresos);
                        }else{
                          return const Text('No hay productos en el inventario');
                        }
                      },
                    ),FutureBuilder<List<Egresos>>(
                      future: egresosFuture ,
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }else if(snapshot.hasError){
                          return Text('${snapshot.error}');
                        } else if(snapshot.hasData){
                          final Egresos = snapshot.data!;
                          return buildEgresos(Egresos);
                        }else{
                          return const Text('No hay productos en el inventario');
                        }
                      },
                    ),
                  ],

            ),

                      ),
                      
                    ],
                  ),
                ),

              ],
            ),
          // ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Row(children: [
          //
          //     Container(
          //       margin: EdgeInsets.only(
          //         bottom: 20,
          //         left: 320,
          //       ),
          //       child: ElevatedButton(
          //         child: Text(
          //           '+',
          //           style: TextStyle(
          //             fontSize: 40,
          //           ),
          //         ),
          //         onPressed: () {
          //           _addToDoItem(_todoController.text);
          //         },
          //         style: ElevatedButton.styleFrom(
          //           primary: tdBlue,
          //           minimumSize: Size(60, 60),
          //           elevation: 10,
          //         ),
          //       ),
          //     ),
          //   ]),
          // ),
    //     ],
    //   ),
    ),
    );
  }

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

  // void _handleToDoChange(ToDo todo) {
  //   setState(() {
  //     todo.isDone = !todo.isDone;
  //   });
  // }
  //
  // void _deleteToDoItem(String id) {
  //   setState(() {
  //     todosList.removeWhere((item) => item.id == id);
  //   });
  // }
  //
  // void _addToDoItem(String toDo) {
  //   setState(() {
  //     todosList.add(ToDo(
  //       id: DateTime.now().millisecondsSinceEpoch.toString(),
  //       todoText: toDo,
  //     ));
  //   });
  //   _todoController.clear();
  // }
  //
  // void _runFilter(String enteredKeyword) {
  //   List<ToDo> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = todosList;
  //   } else {
  //     results = todosList
  //         .where((item) => item.todoText!
  //         .toLowerCase()
  //         .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }
  //
  //   setState(() {
  //     _foundToDo = results;
  //   });
  // }


  Widget buildIngresos(List<Ingresos> Ingresos) =>ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: Ingresos.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 50,
        color: Colors.white,
        child: Center(child: Text('${Ingresos[index].fecha} - ${Ingresos[index].hora}    ${Ingresos[index].nombre}   ${Ingresos[index].total}')),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );

  Widget buildEgresos(List<Egresos> Egresos) =>ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: Egresos.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 50,
        color: Colors.white,
        child: Center(child: Text('${Egresos[index].fecha} - ${Egresos[index].hora}    ${Egresos[index].nombre}   ${Egresos[index].total}')),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );


  Widget searchBox() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            child: Container(
              width: 100,
              height: 50,
              child: Center(
                child: FutureBuilder<List<Ventas>>(
                  future: VentasFuture ,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }else if(snapshot.hasError){
                      return Text('${snapshot.error}');
                    } else if(snapshot.hasData){
                      final Ingresos = snapshot.data!;
                      return Column(
                        children: <Widget>[
                          Text("Utilidad"),

                          Text('${double.parse(Ingresos[0].ventas)-double.parse(Ingresos[0].gastos)}'),
                        ],
                      );;
                    }else{
                      return const Text('No hay productos en el inventario');
                    }
                  },
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              width: 100,
              height:50,
              child: Center(
                child: FutureBuilder<List<Ventas>>(
                  future: VentasFuture ,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }else if(snapshot.hasError){
                      return Text('${snapshot.error}');
                    } else if(snapshot.hasData){
                      final Ingresos = snapshot.data!;
                      return Column(
                        children: <Widget>[
                          Text("Ventas"),

                          Text(Ingresos[0].ventas),
                        ],
                      );;
                    }else{
                      return const Text('No hay productos en el inventario');
                    }
                  },
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              width: 100,
              height: 50,
              child: Center(
                child: FutureBuilder<List<Ventas>>(
                  future: VentasFuture ,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }else if(snapshot.hasError){
                      return Text('${snapshot.error}');
                    } else if(snapshot.hasData){
                      final Ingresos = snapshot.data!;
                      return Column(
                        children: <Widget>[
                          Text("Gastos"),

                          Text(Ingresos[0].gastos),
                        ],
                      );;
                    }else{
                      return const Text('No hay productos en el inventario');
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        ),
      ]),
    );
  }
}