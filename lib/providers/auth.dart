import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:chatapp/global/environment..dart';
import 'package:chatapp/models/login.dart';
import 'package:chatapp/models/usuario.dart';

class AuthProvider with ChangeNotifier{
  late Usuario usuario;
  bool _autentication = false;

  bool get autentication => _autentication;
  set autenticando(bool valor){
    _autentication = valor;
    notifyListeners();
  } 

  // Crear instancias del storage
  final _storage = const FlutterSecureStorage();
  //Getter's Static
  static Future<String?> getToken() async{
    const  _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }
  static Future<void> logoutToken() async{
    const  _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async{
    autenticando = true;

    final data ={
      'correo': email,
      'password': password
    };

    final url = Uri.parse('${Environment.apiUrl}/login');
    final res = await http.post(url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    autenticando = false;
    if(res.statusCode == 200){
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;

      //Almacenar el token
      await _saveToken(loginResponse.token);

      return true;
    }else {

      return false;
    }
  }

  Future register(String nombre, String email, String password, String password2) async{
      autenticando = true;

      final data = {
        'nombre': nombre,
        'correo': email,
        'password': password,
        'password2': password2
      };

      final url = Uri.parse('${Environment.apiUrl}/new');
      final res = await http.post(url, 
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
      );

      autenticando = false;
      if(res.statusCode == 200){
        final registerResponse = loginResponseFromJson(res.body);
        usuario = registerResponse.usuario;

        //Se almacena el token
        await _saveToken(registerResponse.token);
        return true;
      }else {
        final resBody = jsonDecode(res.body);
        return resBody['msg'];
      }
  }

  Future<bool> isLoggedIn() async{
    final token = await _storage.read(key: 'token');

    final url = Uri.parse('${Environment.apiUrl}/token');
    final res = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token!
        }
      );

      if(res.statusCode == 200){
        final tokenResponse = loginResponseFromJson(res.body);
        usuario = tokenResponse.usuario;
        //Se almacena el token
        await _saveToken(tokenResponse.token);
        return true;
      }else {
        logoutToken();
        return false;
      }
  }

  Future _saveToken(String token) async{
    //Escribir el valor del token 
    return await _storage.write(key: 'token', value: token);
  }
  Future _deleteToken() async{
    //Eliminar el token al cerrar 
    return await _storage.delete(key: 'token');
  }
}