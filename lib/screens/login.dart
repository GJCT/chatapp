import 'package:chatapp/helpers/alert.dart';
import 'package:chatapp/providers/auth.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xaaA4F4F4),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Logo(
                  title: 'Messenger',
                ),
                _Form(),
                const Labels(
                  ruta: 'register',
                  text: '¿No tienes cuenta?',
                  textButton: 'Registrate',
                ),
                const Text('Terminos y condiciones de uso', 
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white54),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          InputText(
            icon: Icons.mail_outlined,
            placeholder: 'Email@',
            keyboardtype: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          InputText(
            icon: Icons.lock_outline_rounded,
            placeholder: 'Password',
            //keyboardtype: TextInputType.visiblePassword,
            textController: passCtrl,
            isPassword: true
          ),
          ButtonBlue(
            text: 'Ingresar',
            onPressed: () async{
              //desaparece el teclado
              FocusScope.of(context).unfocus();

              final okLogin = await authProvider.login(
                emailCtrl.text.trim(), 
                passCtrl.text.trim()
              );

              if(okLogin){
                //Conectar al socket

                //Navegar a la proxima pantalla
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else {
                //Mostrar alertas de errores
                mostrarAlert(
                  context, 
                  'Inicio de sesión anulado', 
                  'Revise las credenciales'
                );
              }
            },
          )
        ],
      ),
    );
  }
}

