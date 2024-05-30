import 'package:app_movil/Home/Home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:app_movil/cifradoAsimetrico.dart';
import 'dart:convert';

import '../cifrado.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  String usu= '';
  String pass= '';
  bool _isVisible = false;

  void ingresar (usuario, pass) async {
    try{

      var url = "https://joseviveresm.000webhostapp.com/login?api";

      // getKey(usuario).then((encrypteduser) {
      //   getKey(usuario).then((encryptedpass) async {
      //     print("en camino");
      
      //     var response = await http.post(Uri.parse(url),
      //         body:{'usuario' :encrypteduser,'pass':encryptedpass}
      //     ).timeout(const Duration(seconds: 90));print(response.b10ody);
      //     print(response.body);
      //     if(response.body == '1'){
      
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => Home()),
      //       );
      //     }else{
      
      //       alerta();
      //     }
      //   });
      // });

      var encryptedUser = Encryption.instance.encrypt(usuario);
      var encryptedPass = Encryption.instance.encrypt(pass);
      // var keyPub = getKey();
     //  print(encryptedUser);
      var response = await http.post(Uri.parse(url),
          body:{
          'usuario' :encryptedUser,
          'pass':encryptedPass
      }
      ).timeout(const Duration(seconds: 90));print(response.body);
      if(response.body == '1'){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }else{
        print(response.body);

        alerta();
      }
      } on TimeoutException catch(e){
      print('Tardo mucho la conexion');

      }on Error catch(e){
      print('Http error');
      }
  }

  void alerta() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Las Credenciales son incorrectas'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.shopping_cart,
            size: 100,
            color: Colors.white,
          ),
         RichText(
          text: const TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: 'Market ',
                  style: TextStyle(color: Color.fromRGBO(239, 250, 4, 1), fontSize: 40,  fontWeight: FontWeight.bold)),
                   TextSpan(
                  text: 'MP',
                  style: TextStyle(color: Color.fromRGBO(239, 250, 4, 1), fontSize: 40,  fontWeight: FontWeight.bold))
            ],
          ),

        )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: 'Bienvenid',
                  style: TextStyle(color: Colors.grey, fontSize: 42,  fontWeight: FontWeight.w500)),
                   TextSpan(
                  text: '@',
                  style: TextStyle(color: Color.fromRGBO(239, 250, 4, 1), fontSize: 42,  fontWeight: FontWeight.w500)),
                  TextSpan(
                  text: 's',
                  style: TextStyle(color: Colors.grey, fontSize: 42,  fontWeight: FontWeight.w500))
            ],
          ),

        ),
        // Text(
        //   "Bienvenid@s",
        //   style: TextStyle(
        //       color: Colors.grey, fontSize: 42, fontWeight: FontWeight.w500),
        // ),
        _buildGreyText("Inicio de sesión"),
        const SizedBox(height: 50),
        _buildGreyText("Usuario"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Contraseña"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 40),
        _buildLoginButton(),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return 	
  TextField(
    obscureText: !isPassword ? false : !_isVisible,
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      suffixIcon: IconButton(
        icon: Icon(!isPassword ? Icons.check : !_isVisible ? Icons.visibility_off : Icons.visibility),
        onPressed: () => isPassword ? setState(() {
          _isVisible = !_isVisible;
        }) : {},
      ),
    ),
  );
  }



  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        usu = emailController.text;
        pass = passwordController.text;

        if(usu != '' && pass != ''){
          ingresar(usu, pass);
        }else{
          print('Ingresa datos');
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
       ),
      child: const Text("Iniciar sesión"),
    );
  }
}