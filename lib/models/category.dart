// ignore_for_file: unused_element

import 'dart:convert';

class Categoria {
  Categoria({
    required this.id,
    required this.nombre,
    required this.usuario,
  });

  String id;
  String nombre;
  Usuario usuario;

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        id: json["_id"],
        nombre: json["nombre"],
        usuario: Usuario.fromMap(json["usuario"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "usuario": usuario.toMap(),
      };

  @override
  String toString() {
    return 'Categoria: $nombre';
  }
}

class Usuario {
  Usuario({
    required this.id,
    required this.nombre,
  });

  String id;
  String nombre;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
      };
}
