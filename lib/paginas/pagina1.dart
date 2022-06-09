import 'package:flutter/material.dart';
import 'package:junio_6/widgets/widget_formulario.dart';
import 'package:junio_6/widgets/widget_tab1.dart';

import '../widgets/widget_tab2.dart';

class Pagina1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Pagina1Estado();
  }
}

class Pagina1Estado extends State<Pagina1> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 2,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("titulo"),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.cloud_outlined),
                ),
                Tab(
                  icon: Icon(Icons.beach_access_sharp),
                ),
                Tab(
                  icon: Icon(Icons.brightness_5_sharp),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            selectedItemColor: Colors.amber[800],
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: WidgetTab1(),
              ),
              Center(
                child: WidgetTab2(),
              ),
              Center(
                child: WidgetFormulario(),
              ),
            ],
          ),
        ));
  }
}
