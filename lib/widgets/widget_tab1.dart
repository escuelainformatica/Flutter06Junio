import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modelo/producto.dart';

class WidgetTab1 extends StatelessWidget {

  Stream<List<Producto>> obtenerProductos() async* {
    var url = Uri.http('158.101.30.194', '/testcli/api/Product/listall');
    var response = await http.get(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8', // aqui deberiamos agregar la autenticacion
        });
    if (response.statusCode >= 200 && response.statusCode <= 209) {
      // si la respuesta es correcta:
      // 1) convertimos la respuesta en una lista de mapas.
      var mapas = jsonDecode(response.body).cast<Map<String, dynamic>>();
      // 2) y luego transformamos cada map en una lista de productos
      List<Producto> productos = mapas.map<Producto>((item) =>
          Producto.fromMap(item)).toList();
      // y devolvelos la lista de productos
      yield productos; // yield se usa en stream, future no usa yield.
    } else {
      // o sino, devolvemos una excepcion
      throw Exception('Error code ${response.statusCode} ');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: [], // lista vacia
      stream: obtenerProductos(),
        builder: (context, snapshot ) {
            if(snapshot.hasError) {
              // error
              return Text("error ${snapshot.error}");
            } else {
              if(snapshot.connectionState==ConnectionState.done && snapshot.data!=null) {
                List<Producto> valores = snapshot.data as List<Producto>;
                return ListView.builder(
                    itemCount: valores.length,
                    itemBuilder: (context, fila) {
                      return Card(
                        child: ListTile(
                          leading: Text(valores[fila].Name),
                          title: Text(valores[fila].Price.toString()),
                        )
                      );
                    }
                );
              } else {
                return Text("cargando (o no hay datos)..");
              }
            }

        }
    );
  }

}