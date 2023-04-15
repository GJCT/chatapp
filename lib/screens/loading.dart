import 'package:chatapp/providers/provider.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
   
  const LoadingScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
           child: Text('Redirigiendo...'),
          );
        },
      ),
    );
  }


  Future checkLoginState(BuildContext context) async{
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);

    final autenticado = await authProvider.isLoggedIn();

    if(autenticado){
      print(autenticado);
      //Conectar al Socket
      socketProvider.connect();
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___)=> const UsuariosScreen()
        )
      );
    }else {
      print(autenticado);
      socketProvider.disconnect();
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___)=> const LoginScreen()
        )
      );
    }
  }
}