import 'package:flutter/material.dart';
import 'package:junio_6/modelo/mi_modelo.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:junio_6/modelo/producto.dart';

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
  final _campo3Controller = TextEditingController(text: "");
  String dropdownValue = 'One';
  Producto producto = new Producto.name(0, "", 0, 0.0);

  Future<String> envio() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.http('seg.cl', '/api/api/Product/insert');
    //Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    producto.Name = _campo1Controller.text;
    producto.Price = double.parse(_campo2Controller.text);
    producto.IdProductCategory = int.parse(_campo3Controller.text);

    var json = convert.jsonEncode(producto.toMap());

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,
       headers: <String, String>{ 'content-type': 'application/json; charset=UTF-8',},
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
            TextFormField(
              controller: _campo2Controller,
            ),
            TextFormField(
              controller: _campo3Controller,
            ),
            const SizedBox(height: 30),
            OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var r = await envio();

                    _campo1Controller.text="";
                    _campo2Controller.text="0";
                    _campo3Controller.text="0";

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
