  import 'package:cafeteria/services/api_connector.dart';
import 'package:flutter/material.dart';

  import '../../models/Plato.dart';

  class AcompanhamientosScreen extends StatefulWidget {
    final Plato plato;
    final List<String?> acompanhamientosSeleccionados;
    final List<String?> ensaladasSeleccionadas;
    final List<String?> salsasSeleccionadas;

    AcompanhamientosScreen({
      Key? key,
      required this.plato,
    })   : acompanhamientosSeleccionados = List<String?>.filled(plato.acompanhamientos, null, growable: false),
          ensaladasSeleccionadas = List<String?>.filled(plato.ensaladas, null, growable: false),
          salsasSeleccionadas = List<String?>.filled(plato.salsas, null, growable: false),
          super(key: key);

    @override
    _AcompanhamientosScreenState createState() => _AcompanhamientosScreenState();
  }

  class _AcompanhamientosScreenState extends State<AcompanhamientosScreen> {

    @override
    Widget build(BuildContext context) {
      List<String?> guarnicionesDisponibles;
      List<String?> ensaladasDisponibles;
      List<String?> salsasDisponibles;
      Plato almuerzo = widget.plato;
      List<String?> acompanhamientosSeleccionados = widget.acompanhamientosSeleccionados;
      List<String?> ensaladasSeleccionadas = widget.ensaladasSeleccionadas;
      List<String?> salsasSeleccionadas = widget.salsasSeleccionadas;

      return FutureBuilder<List<String>>(
        future: ApiConnector.instance.getGuarniciones(),
        builder: (context, snapshotGuarniciones) {
          if (snapshotGuarniciones.hasData) {
            guarnicionesDisponibles = snapshotGuarniciones.data ?? [];
            return FutureBuilder<List<String>>(
              future: ApiConnector.instance.getEnsaladas(),
              builder: (context, snapshotEnsaladas) {
                if (snapshotEnsaladas.hasData) {
                  ensaladasDisponibles = snapshotEnsaladas.data ?? [];
                  return FutureBuilder<List<String>>(
                    future: ApiConnector.instance.getSalsas(),
                    builder: (context, snapshotSalsas) {
                      if (snapshotSalsas.hasData) {
                        salsasDisponibles = snapshotSalsas.data ?? [];
                        return Scaffold(
                          appBar: AppBar(
                            backgroundColor: Color.fromARGB(255, 107, 142, 35),
                            title: Text(almuerzo.nombre),
                          ),
                          backgroundColor: Colors.lightGreen.shade200,
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
                                        value: acompanhamientosSeleccionados[i],
                                        hint: Text('Seleccione un acompañamiento'),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            acompanhamientosSeleccionados[i] = newValue!;
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
                                        value: ensaladasSeleccionadas[i],
                                        hint: Text('Seleccione una ensalada'),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            ensaladasSeleccionadas[i] = newValue!;
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
                                for (int i = 0; i < almuerzo.salsas; i++)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Salsa ${i + 1}:',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        value: salsasSeleccionadas[i],
                                        hint: Text('Seleccione una salsa'),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            salsasSeleccionadas[i] = newValue!;
                                          });
                                        },
                                        items: salsasDisponibles.map((String? value) {
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
                              // Puedes utilizar las variables acompanhamientoSeleccionado, ensaladaSeleccionada y salsasSeleccionadas
                            },
                            child: Icon(Icons.check),
                          ),
                        );
                      } else if (snapshotSalsas.hasError) {
                        return Text('Error al obtener la lista de salsas');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                } else if (snapshotEnsaladas.hasError) {
                  return Text('Error al obtener la lista de ensaladas');
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          } else if (snapshotGuarniciones.hasError) {
            return Text('Error al obtener la lista de guarniciones');
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }

  }
