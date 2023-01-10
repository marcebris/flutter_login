// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';

import 'header.dart';


class LoginResponse {
    LoginResponse({
        this.header,
        this.nombre,
        this.email,
        this.nombreUsuario,
        this.idUsuario,
        this.esValido,
        this.cambiarClave,
        this.estaBloqueado,
        this.fotoPerfil,
    });

    Header? header;
    String? nombre;
    String? email;
    String? nombreUsuario;
    int? idUsuario;
    bool? esValido;
    bool? cambiarClave;
    bool? estaBloqueado;
    String? fotoPerfil;

    factory LoginResponse.fromJson(String str) { 
      return LoginResponse.fromMap(json.decode(str));
      }

    String toJson() => json.encode(toMap());

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        header: Header.fromMap(json["Header"]),
        nombre: json["Nombre"],
        email: json["Email"],
        nombreUsuario: json["NombreUsuario"],
        idUsuario: json["IDUsuario"],
        esValido: json["EsValido"] ?? false,
        cambiarClave: json["CambiarClave"] ?? false,
        estaBloqueado: json["EstaBloqueado"] ?? false,
        fotoPerfil: json["FotoPerfil"],
    );

    Map<String, dynamic> toMap() => {
        "Header": header ?? header!.toMap(),
        "Nombre": nombre,
        "Email": email,
        "NombreUsuario": nombreUsuario,
        "IDUsuario": idUsuario,
        "EsValido": esValido,
        "CambiarClave": cambiarClave,
        "EstaBloqueado": estaBloqueado,
        "FotoPerfil": fotoPerfil,
    };
}


