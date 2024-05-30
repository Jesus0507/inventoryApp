import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ingreso extends StatefulWidget {
  const Ingreso({super.key});

  @override
  State<Ingreso> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Ingreso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xEEEEEEEF),
        body: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            SizedBox(height: 25.0,),
            Padding(padding: EdgeInsets.only(left: 5.0),
                child: Row(children: <Widget>[
                  Text("Ingreso Producto",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:25.0,
                          color: Colors.black87
                      )
                  )
                ])
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 105.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), topLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
              ),
            )
          ],
        )
    );
  }
}
