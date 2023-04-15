import 'package:chatapp/global/environment..dart';
import 'package:chatapp/providers/provider.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class UsuariosProvider{
  Future<List<Usuario>> getUsuarios() async{
    try {

      final uri = Uri.parse('${Environment.apiUrl}/usuarios');
      final resp = await http.get(uri, 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthProvider.getToken()
        }
      );
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }
  }
}