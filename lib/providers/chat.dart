import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/models/models.dart';
import 'package:chatapp/providers/provider.dart';
import 'package:chatapp/global/environment..dart';

class ChatProvider with ChangeNotifier{

  late Usuario usuarioMsg;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.socketUrl}/mensajes/$usuarioID');
    final res = await http.get(uri, 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': await AuthProvider.getToken()
      }
    );

    final mensajeResponse = mensajeResponseFromJson(res.body);

    return mensajeResponse.mensajes;
  }

}