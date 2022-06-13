import 'package:flutter/material.dart';
import 'package:junio_6/modelo/mi_modelo.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:junio_6/modelo/producto.dart';
import 'package:junio_6/widgets/widget_producto_categoria.dart';

class WidgetFormulario extends StatefulWidget {
  const WidgetFormulario({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WidgetFormulario();
  }
}

class _WidgetFormulario extends State<WidgetFormulario> {
  final _formKey = GlobalKey<FormState>();
  final _campo1Controller = TextEditingController(text: "");
  final _campo2Controller = TextEditingController(text: "");
  String dropdownValue = '';
  Producto producto = Producto.name(0, "", 0, 0.0);

  Future<String> envio() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.http('158.101.30.194', '/testcli/api/Product/insert');



    // creamos un objeto del tipo producto usando los datos de la pantalla.
    producto.Name = _campo1Controller.text;
    producto.Price = double.parse(_campo2Controller.text);
    producto.IdProductCategory = int.parse(dropdownValue);

    // y convertimos ese producto en un json
    var json = convert.jsonEncode(producto.toMap());

    // enviamos el valor por el encabezado del post y esperamos una respuesta
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          // aqui deberiamos agregar la autenticacion
        },
        body: json);
    var respuesta = "";
    if (response.statusCode >= 200 && response.statusCode <= 209) {
      respuesta = response.body;
      //valores=MiModelo.fromJson(jsonResponse);
    }
    return respuesta;
  }

  @override
  Widget build(BuildContext context) {



    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _campo1Controller,
            ),
            WidgetProductoCategoria(seleccion: dropdownValue,onTouched: (value) {
              dropdownValue=value;
            },),
            TextFormField(
              controller: _campo2Controller,
            ),
            const SizedBox(height: 30),
            OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var r = await envio();

                    _campo1Controller.text = "";
                    _campo2Controller.text = "0";

                    dropdownValue = "";

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(r),
                    ));
                  }
                },
                child: const Text("Enviar datos"))
          ],
        ),
      ),
    );
  }
}
