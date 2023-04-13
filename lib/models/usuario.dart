// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        required this.online,
        required this.nombre,
        required this.correo,
        required this.uid,
    });

    bool? online;
    String nombre;
    String correo;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        nombre: json["nombre"],
        correo: json["correo"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "correo": correo,
        "uid": uid,
    };
}
