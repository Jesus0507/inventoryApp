// import 'package:app_movil/Balance/Balance.dart';
//import 'package:app_movil/Balance/Balance2.dart';
import 'package:app_movil/Inventario/Inventario.dart';
import 'package:app_movil/Cuentas/cuentas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final views = [  Inventario(0), Cuentas(0)];

    return Scaffold(
      body:IndexedStack(
        index: selectedIndex,
        children: views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        unselectedItemColor: Colors.black54,
        items: [
           BottomNavigationBarItem(
            icon: const Icon(Icons.inventory_2),
            activeIcon: const Icon(Icons.inventory_2_outlined,color: Colors.yellow),
            label:'Inventario',
            backgroundColor:  Color(0xFFA4A4A4),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            activeIcon: const Icon(Icons.list_alt_outlined, color: Colors.yellow),
            label:'Cuentas',
            backgroundColor: Color(0xFFA4A4A4),
          ),
        ],
      ),
    );
  }
}