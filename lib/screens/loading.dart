import 'package:chatapp/providers/auth.dart';
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

    final autenticado = await authProvider.isLoggedIn();

    if(autenticado){
      //Conectar al Socket
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___)=> const UsuariosScreen()
        )
      );
    }else {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___)=> const LoginScreen()
        )
      );
    }
  }
}