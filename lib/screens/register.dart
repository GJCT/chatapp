import 'package:chatapp/helpers/alert.dart';
import 'package:chatapp/providers/provider.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);
  
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
                  title: 'Registro',
                ),
                _Form(),
                const Labels(
                  ruta: 'login',
                  text: '¿Ya tienes cuenta?',
                  textButton: 'Inicia sesión',
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

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();
  final passCtrl2  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          InputText(
            icon: Icons.person_outlined,
            placeholder: 'Nombre',
            keyboardtype: TextInputType.text,
            textController: nameCtrl,
          ),
          InputText(
            icon: Icons.mail_outlined,
            placeholder: '@Correo',
            keyboardtype: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          InputText(
            icon: Icons.lock_outline_rounded,
            placeholder: 'Contraseña',
            //keyboardtype: TextInputType.visiblePassword,
            textController: passCtrl,
            isPassword: true
          ),
          InputText(
            icon: Icons.lock_outline_rounded,
            placeholder: 'Confirmar contraseña',
            //keyboardtype: TextInputType.visiblePassword,
            textController: passCtrl2,
            isPassword: true
          ),
          ButtonBlue(
            text: 'registrar',
            onPressed: () async{
              //desaparece el teclado
              FocusScope.of(context).unfocus();

              final okRegister = await authProvider.register(
                nameCtrl.text.trim(),
                emailCtrl.text.trim(), 
                passCtrl.text.trim(),
                passCtrl2.text.trim()
              );

              if(okRegister == true){
                //Conectar al socket
                socketProvider.connect();
                //Navegar a la proxima pantalla
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else {
                //Mostrar alertas de errores
                mostrarAlert(
                  context, 
                  'Registro anulado', 
                  okRegister
                );
              }
            },
          )
        ],
      ),
    );
  }
}

