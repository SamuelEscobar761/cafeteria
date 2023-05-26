  import 'package:cafeteria/services/api_connector.dart';
import 'package:flutter/material.dart';

  import '../../models/Plato.dart';

  class AcompanhamientosScreen extends StatefulWidget {
    final Plato plato;
    List<String?> acompanhamientosSeleccionado;
    List<String?> ensaladasSeleccionada;

    AcompanhamientosScreen({
      Key? key,
      required this.plato,
    })   : acompanhamientosSeleccionado = List<String?>.filled(plato.acompanhamientos, null, growable: false),
          ensaladasSeleccionada = List<String?>.filled(plato.ensaladas, null, growable: false),
          super(key: key);

    @override
    _AcompanhamientosScreenState createState() => _AcompanhamientosScreenState();
  }

  class _AcompanhamientosScreenState extends State<AcompanhamientosScreen> {

    @override
    Widget build(BuildContext context) {
      List<String?> guarnicionesDisponibles;
      List<String?> ensaladasDisponibles;
      Plato almuerzo = widget.plato;
      List<String?> acompanhamientosSeleccionado = widget.acompanhamientosSeleccionado;
      List<String?> ensaladasSeleccionada = widget.ensaladasSeleccionada;

      return FutureBuilder<List<String>>(
        future: ApiConnector.instance.getGuarniciones(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            guarnicionesDisponibles = snapshot.data ?? [];
            return FutureBuilder<List<String>>(
              future: ApiConnector.instance.getEnsaladas(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ensaladasDisponibles = snapshot.data ?? [];
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(almuerzo.nombre),
                    ),
                    body: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < almuerzo.acompanhamientos; i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Acompañamiento ${i + 1}:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: acompanhamientosSeleccionado[i],
                                  hint: Text('Seleccione un acompañamiento'),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      acompanhamientosSeleccionado[i] = newValue!;
                                    });
                                  },
                                  items: guarnicionesDisponibles.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value ?? ''),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 16.0),
                              ],
                            ),
                          for (int i = 0; i < almuerzo.ensaladas; i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ensalada ${i + 1}:',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: ensaladasSeleccionada[i],
                                  hint: Text('Seleccione una ensalada'),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      ensaladasSeleccionada[i] = newValue!;
                                    });
                                  },
                                  items: ensaladasDisponibles.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value ?? ''),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 16.0),
                              ],
                            ),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        // Acción a realizar al presionar el botón de finalizar
                        // Puedes utilizar las variables acompanhamientoSeleccionado y ensaladaSeleccionada
                      },
                      child: Icon(Icons.check),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error al obtener la lista de ensaladas');
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error al obtener la lista de guarniciones');
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }
}
