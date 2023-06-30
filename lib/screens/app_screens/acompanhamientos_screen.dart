import 'package:cafeteria/models/Cliente.dart';
import 'package:flutter/material.dart';
import '../../models/almuerzo.dart';
import '../../models/ensalada.dart';
import '../../models/guarnicion.dart';
import '../../models/salsa.dart';
import '../../services/api_connector.dart';

  class AcompanhamientosScreen extends StatefulWidget {
    final Almuerzo almuerzo;
    final String id_cliente;
    final List<String?> acompanhamientosSeleccionados;
    final List<String?> ensaladasSeleccionadas;
    final List<String?> salsasSeleccionadas;

    AcompanhamientosScreen({
      Key? key,
      required this.almuerzo,
      required this.id_cliente,
    })   : acompanhamientosSeleccionados = List<String?>.filled(almuerzo.guarniciones, null, growable: false),
          ensaladasSeleccionadas = List<String?>.filled(almuerzo.ensaladas, null, growable: false),
          salsasSeleccionadas = List<String?>.filled(almuerzo.salsas, null, growable: false),
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
      Almuerzo almuerzo = widget.almuerzo;
      String id_cliente = widget.id_cliente;
      List<String?> acompanhamientosSeleccionados = widget.acompanhamientosSeleccionados;
      List<String?> ensaladasSeleccionadas = widget.ensaladasSeleccionadas;
      List<String?> salsasSeleccionadas = widget.salsasSeleccionadas;

      return FutureBuilder<List<Guarnicion>>(
        future: ApiConnector.instance.getGuarniciones(almuerzo.id),
        builder: (context, snapshotGuarniciones) {
          if (snapshotGuarniciones.hasData) {
            guarnicionesDisponibles = snapshotGuarniciones.data?.map((guarnicion) => guarnicion.nombre).toList() ?? [];
            return FutureBuilder<List<Ensalada>>(
              future: ApiConnector.instance.getEnsaladas(almuerzo.id),
              builder: (context, snapshotEnsaladas) {
                if (snapshotEnsaladas.hasData) {
                  ensaladasDisponibles = snapshotEnsaladas.data?.map((ensalada) => ensalada.nombre).toList() ?? [];
                  return FutureBuilder<List<Salsa>>(
                    future: ApiConnector.instance.getSalsas(almuerzo.id),
                    builder: (context, snapshotSalsas) {
                      if (snapshotSalsas.hasData) {
                        salsasDisponibles = snapshotSalsas.data?.map((salsa) => salsa.nombre).toList() ?? [];
                        var isParaLlevar = false;
                        return Scaffold(
                          appBar: AppBar(
                            backgroundColor: Color.fromARGB(255, 107, 142, 35),
                            title: Text(
                              almuerzo.nombre,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.lightGreen.shade200,
                          body: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Acompañamientos:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                for (int i = 0; i < almuerzo.guarniciones; i++)
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
                                Text(
                                  'Ensaladas:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
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
                                Text(
                                  'Salsas:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
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
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isParaLlevar,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isParaLlevar = newValue ?? false;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Para llevar',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () {
                              // Acción a realizar al presionar el botón de finalizar
                              // Puedes utilizar las variables acompanhamientoSeleccionado, ensaladaSeleccionada y salsasSeleccionadas
                              Navigator.pushNamed(
                                context,
                                '/qr',
                                  arguments: {
                                    'almuerzo': almuerzo,
                                    'id_cliente': id_cliente,
                                    'guarniciones': acompanhamientosSeleccionados,
                                    'ensaladas': ensaladasSeleccionadas,
                                    'salsas': salsasSeleccionadas,

                                  },// Pasas el objeto cliente como argumento
                              );
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
