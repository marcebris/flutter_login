import 'dart:convert';

class Header {
    Header({
        this.code,
        this.message
    });

    String? code;
    String? message;

    factory Header.fromJson(String str) => Header.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Header.fromMap(Map<String, dynamic> json) => Header(
        code: json["Code"],
        message: json["Message"]
    );

    Map<String, dynamic> toMap() => {
        "Code": code,
        "Message": message
    };
}