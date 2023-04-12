

import 'package:chatapp/screens/chat.dart';
import 'package:chatapp/screens/loading.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/register.dart';
import 'package:chatapp/screens/usuarios.dart';

final appRoutes = {
  'usuarios':  ( _)   => const UsuariosScreen(),
  'chat':     ( _)   => const ChatScreen(),
  'loading':  ( _)   => const LoadingScreen(),
  'login':    ( _)   => const LoginScreen(),
  'register': ( _)   => const RegisterScreen(),
};