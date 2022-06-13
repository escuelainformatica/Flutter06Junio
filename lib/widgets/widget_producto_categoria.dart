import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:junio_6/modelo/product_category.dart';

class WidgetProductoCategoria extends StatefulWidget {
  String? seleccion;
  Function onTouched;
  WidgetProductoCategoria({Key? key,this.seleccion,required this.onTouched}) : super(key: key);


  

  @override
  State<StatefulWidget> createState() {

    return _WidgetProductoCategoria();
  }
}

class _WidgetProductoCategoria extends State<WidgetProductoCategoria> {
  Stream<List<ProductCategory>> obtenerCategorias() async* {
    var url =
        Uri.http('158.101.30.194', '/testcli/api/Productcategory/listall');
    var response = await http.get(url, headers: <String, String>{
      'content-type': 'application/json; charset=UTF-8',
      // aqui deberiamos agregar la autenticacion
    });
    if (response.statusCode >= 200 && response.statusCode <= 209) {
      // si la respuesta es correcta:
      // 1) convertimos la respuesta en una lista de mapas.
      var mapas = jsonDecode(response.body).cast<Map<String, dynamic>>();
      // 2) y luego transformamos cada map en una lista de productos
      List<ProductCategory> categorias = mapas
          .map<ProductCategory>((item) => ProductCategory.fromMap(item))
          .toList();
      // y devolvelos la lista de productos
      yield categorias; // yield se usa en stream, future no usa yield.
    } else {
      // o sino, devolvemos una excepcion
      throw Exception('Error code ${response.statusCode} ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: obtenerCategorias(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // error
            return Text("error ${snapshot.error}");
          } else {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              List<ProductCategory> valores = snapshot.data as List<ProductCategory>;
              // transformar los valores en una lista de DropdownMenuItem
              List<DropdownMenuItem<String>> itemCombo=valores
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(value: e.IdProductCategory.toString(),child: Text(e.Name),)).toList();
              itemCombo.add(DropdownMenuItem(child: Text(""),value: ""));
              return DropdownButtonFormField<String>(
                value: widget.seleccion ,
                  items: itemCombo,
                  onChanged: (valor) {
                    widget.seleccion=valor as String;
                    widget.onTouched(widget.seleccion);
                  });
            }
          }
          return Text("no cargado");
        });
  }
}
