import 'package:cafeteria/services/api_connector.dart';
import 'package:flutter/material.dart';

import '../../models/Plato.dart';
import '../../models/Cliente.dart';
import '../constants.dart';
import 'acompanhamientos_screen.dart';

class MenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Recibiendo el argumento del objeto cliente
    final cliente = ModalRoute.of(context)?.settings.arguments as Cliente?;

    return FutureBuilder<List<Plato>>(
      future: ApiConnector.instance.getPlatos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Plato>? platos = snapshot.data;
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Escoge tu almuerzo',
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
                      Plato plato = platos![index];
                      EdgeInsets margin = index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 5.0);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AcompanhamientosScreen(plato: plato),
                            ),
                          );
                        },
                        child: Container(
                          margin: margin,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: Image.asset(plato.imagen),
                            title: Text(plato.nombre),
                            subtitle: Text(plato.descripcion),
                            trailing: Text("Bs. ${plato.precio.toStringAsFixed(2)}"),
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