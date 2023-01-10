// To parse this JSON data, do
//
//     final resetPassResponse = resetPassResponseFromMap(jsonString);

import 'dart:convert';

import 'header.dart';

class ResetPassResponse {
    ResetPassResponse({
        this.header,
        required this.resultado,
    });

    Header? header;
    bool resultado;

    factory ResetPassResponse.fromJson(String str) => ResetPassResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ResetPassResponse.fromMap(Map<String, dynamic> json) => ResetPassResponse(
        header: Header.fromMap(json["Header"]),
        resultado: json["Resultado"] ?? false,
    );

    Map<String, dynamic> toMap() => {
        "Header": header!.toMap(),
        "Resultado": resultado,
    };
}

