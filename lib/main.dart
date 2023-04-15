import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/providers/provider.dart';
import 'package:chatapp/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _) => AuthProvider()),
        ChangeNotifierProvider(create: ( _) => SocketProvider()),
        ChangeNotifierProvider(create: ( _) => ChatProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}