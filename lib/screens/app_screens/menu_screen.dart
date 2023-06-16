import 'package:cafeteria/services/api_connector.dart';
import 'package:flutter/material.dart';

import '../../models/almuerzo.dart';
import '../../models/Cliente.dart';
import '../constants.dart';
import 'acompanhamientos_screen.dart';

class MenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Recibiendo el argumento del objeto cliente
    final cliente = ModalRoute.of(context)?.settings.arguments as Cliente?;

    return FutureBuilder<List<Almuerzo>>(
      future: ApiConnector.instance.getAlmuerzos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Almuerzo>? platos = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 107, 142, 35),
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, size: 24, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    '¿Qué vas a comer hoy?',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              elevation: 0,
            ),
            backgroundColor: Colors.lightGreen.shade200,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Nuestro menu de hoy',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: platos?.length,
                    itemBuilder: (context, index) {
                      Almuerzo plato = platos![index];
                      EdgeInsets margin = index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.0);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AcompanhamientosScreen(almuerzo: plato),
                            ),
                          );
                        },
                        child: Container(
                          margin: margin,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                plato.imagen,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              plato.nombre,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              plato.descripcion,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: Text(
                              "Bs. ${plato.precio.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error al obtener la lista de platos');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}