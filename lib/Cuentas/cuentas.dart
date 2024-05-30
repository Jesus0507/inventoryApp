import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_movil/constants.dart';
import 'package:app_movil/Cuentas/cuentasPagar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../login/Login.dart';

class Cuentas extends StatefulWidget {
  final int cantId;
  const Cuentas(this.cantId, {Key? key}) : super(key: key);
  @override
  State<Cuentas> createState() => _CuentasState();
}

class _CuentasState extends State<Cuentas> with TickerProviderStateMixin {
  Future<List<CuentasDeudas>>cuentasFuture = getCuentasPagar();
  Future<List<CuentasDeudas>>cuentasCobrarFuture = getCuentasCobrar();
  static List<Tab> myTabs = <Tab>[
    const Tab(
        key: Key('1'),
        child: Text(
          'CUENTAS POR PAGAR',
          style: TextStyle(color: Colors.red),
        )),
    const Tab(
        key: Key('2'),
        child: Text(
          'CUENTAS POR COBRAR',
          style: TextStyle(color: Colors.green),
        )),
  ];
  static List<Tab> myPopUpTabs = <Tab>[
    const Tab(
        key: Key('1'),
        child: Text(
          'Cuenta',
          style: TextStyle(color: Colors.red),
        )),
    const Tab(
        key: Key('2'),
        child: Text(
          'Abonos',
          style: TextStyle(color: Colors.green),
        )),
  ];


static Future<List<CuentasDeudas>> getCuentasPagar() async {
  var response = await http.get(Uri.parse('https://joseviveresm.000webhostapp.com/deudas/listarDeudasPagar/api?api'));
   final body = json.decode(response.body); 
   return body.map<CuentasDeudas>(CuentasDeudas.fromJson).toList();
}

static Future<List<CuentasDeudas>> getCuentasCobrar() async {
  var response = await http.get(Uri.parse('https://joseviveresm.000webhostapp.com/deudas/listarDeudasCobrar/api?api'));
   final body = json.decode(response.body); 
   return body.map<CuentasDeudas>(CuentasDeudas.fromJson).toList();
}


  late TabController _tabController;
  late TabController _tabPopUpController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabPopUpController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabPopUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          indicatorColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((
          Tab tab,
        ) {
          var tabIndex = int.parse(tab.key.toString().split("'")[1]);
           print(tabIndex);
          return Center(
              child:
               FutureBuilder<List>(
              future: tabIndex == 1? cuentasFuture : cuentasCobrarFuture,
              builder:(context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      } else if(snapshot.hasData){
                        var cuentasList = snapshot.data!;
                        return   Container(
            width: MediaQuery.of(context).size.width,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Row(children: [
                    Text('Total:', style: TextStyle(fontSize: 25)),
                    Spacer(),
                    Text(cuentasList[0].total, style: TextStyle(fontSize: 25)),
                    Icon(Icons.attach_money, size: 30, color: tabIndex > 1 ? Colors.green : Colors.red )
                  ])),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey),
              Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: 
                   ListView.builder(
                                  itemCount: cuentasList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.72,
                                  child: Row(
                                  children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        ),
                                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 13.0),
                                      child: Text(cuentasList[index].cant.toString(), style: TextStyle(color:Colors.white, fontSize: 20)),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: Text(cuentasList[index].nombre, style: TextStyle(fontSize: 20),),),
                                            Spacer(),
                                      Container(
                                        child: Text(cuentasList[index].suma, style: TextStyle(fontSize: 20),),),
                                          Spacer(),
                                      Container(
                                        margin: const EdgeInsets.only(right: 20.0),
                                        child: IconButton(
                                          icon: const Icon(Icons.more_horiz, size: 35),
                                          onPressed: () =>  showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                            
                                              return AlertDialog(
                                                scrollable: true,
                                                title: tabIndex > 1 ? Text('Cuenta por cobrar') : Text('Cuenta por pagar'),
                                                content: Container(
                                                width: MediaQuery.of(context).size.width * 0.80,
                                                height: MediaQuery.of(context).size.height * 0.50,
                                                child: 
                                                Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Form(
                                                    child: Column(
                                                      children: [
                                                       TabBar(
                                                        tabs: myPopUpTabs,
                                                        controller: _tabPopUpController,
                                                        indicatorColor: Colors.grey),
                                                        Expanded(child: 
                                                         TabBarView(
                                                          controller: _tabPopUpController,
                                                          children:[
                                                          Container(
                                                            margin:const EdgeInsets.only(top:20),
                                                            child:
                                                            Center(child: 
                                                            Column(
                                                              children: [
                                                                Text(cuentasList[index].nombre),
                                                                Container(
                                                                  child: Card(
                                                                    child: Center (child: 
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Center(child:
                                                                      Container(
                                                                        margin: EdgeInsets.only(top:20),
                                                                        child:
                                                                         RichText(
                                                                          text: TextSpan(
                                                                            text: '',
                                                                            children: [
                                                                              WidgetSpan(
                                                                              child: Container(
                                                                               margin: const EdgeInsets.only(right:10),
                                                                              decoration: const BoxDecoration(
                                                                              color: Colors.green,
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(100.0),
                                                                              ),
                                                                              ),
                                                                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                                                                            child: Text(cuentasList[index].cant.toString(), style: TextStyle(color:Colors.white, fontSize: 15)),
                                                                            ),
                                                                            ),
                                                                          WidgetSpan(
                                                                              child:  Container(
                                                                                margin: const EdgeInsets.only(bottom:3),
                                                                            child: const Text('Cuentas', style: TextStyle(color:Colors.black, fontSize: 15)),
                                                                            ),
                                                                            ),
                                                                         ]),
                                                                        )
                                                                      ),
                                                        
                                                                //            Row(
                                                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                                                //         children: [
                                                                //         Container(
                                                                //           margin: EdgeInsets.only(top:20, right:10),
                                                                //   decoration: const BoxDecoration(
                                                                //   color: Colors.green,
                                                                //   borderRadius: BorderRadius.all(
                                                                //     Radius.circular(100.0),
                                                                //   ),
                                                                //   ),
                                                                // padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                                                                // child: Text(cuentasList[index].cant.toString(), style: TextStyle(color:Colors.white, fontSize: 15)),
                                                                // ),
                                                                // Container(
                                                                // margin: EdgeInsets.only(top:20),
                                                                // child:
                                                                // Text('Cuentas') )
                                                                //       ],)
                                                                      ),
                                                                       Container(
                                                                        width: MediaQuery.of(context).size.width * 0.80,
                                                                        margin: EdgeInsets.all(20),
                                                                        child: Row(
                                                                          children:[
                                                                          Text(cuentasList[index].suma.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                                                                         const Spacer(),
                                                                         const Icon(Icons.attach_money, color: Colors.green, size: 22,)
                                                                          ]
                                                                        )
                                                                      ),
                                                                    ]),)
                                                                  )
                                                                ),
                    
                                                              ],
                                                            ),)
                                                            
                                                          ),
                                                          Text('adios')
                                                          ]))
                                                       
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    child: const Text("submit"),
                                                    onPressed: () {
                                                      // your code
                                                    },
                                                  ),
                                                ],
                                              );
                                            },),),)
                                        ],));
                                        },
                                      )
              )
            ]),
          );
                      }else{
                        return const Text('No hay categorias registradas');
                      }
              }
              )
              );
        }).toList(),
      ),
    );
  }
}
