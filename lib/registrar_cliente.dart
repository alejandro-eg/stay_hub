import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stay_hub/shared_preferences_manager.dart';

class RegistrarCliente extends StatefulWidget {
  const RegistrarCliente({super.key});

  @override
  _RegistrarClienteState createState() => _RegistrarClienteState();
}
class _RegistrarClienteState extends State<RegistrarCliente> {
  String? _selectedNacionalidad;
  final TextEditingController _nombreClienteController = TextEditingController();
  final TextEditingController _apellidoClienteController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();

  List<String> nacionalidad = ['afgano', 'alemán', 'árabe', 'argentino', 'australiano', 'belga', 'boliviano', 'brasileño', 'canadiense', 'chileno', 'chino', 'colombiano', 'coreano', 'costarricense',
                                'cubano', 'danés', 'ecuatoriano', 'egipcio', 'salvadoreño', 'español', 'estadounidense', 'francés', 'griego', 'guatemalteco', 'haitiano', '	holandés', 'hondureño', 'inglés',
                                'iraní', 'israelí', 'italiano', 'japonés', 'marroquí', 'mexicano', 'nicaragüense', 'paraguayo', 'peruano', 'portugués','Otra'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Cliente'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/stayhub.png',
                height: 200,
                width: 200),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nombreClienteController,
                decoration: const InputDecoration(
                    labelText: 'Nombre del Cliente (Mayúsculas)'),
                inputFormatters: [UpperCaseTextFormatter()],
              ),
              TextField(
                controller: _apellidoClienteController,
                decoration:
                    const InputDecoration(labelText: 'Apellido del Cliente (Mayúsculas)'),
                inputFormatters: [UpperCaseTextFormatter()],
              ),
              TextField(
                controller: _cedulaController,
                decoration: const InputDecoration(
                    labelText: 'Cédula del Cliente(Solo Números)'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              DropdownButton<String>(
                hint: const Text('Seleccione la Nacionalidad'),
                value: _selectedNacionalidad,
                onChanged: (String? value) {
                  setState(() {
                    _selectedNacionalidad = value;
                  });
                },
                items: nacionalidad.map<DropdownMenuItem<String>>((String nacionalidad) {
                  return DropdownMenuItem<String>(
                    value: nacionalidad,
                    child: Text(nacionalidad),
                  );
                }).toList(),
              ),
              TextField(
                controller: _fechaNacimientoController,
                decoration: const InputDecoration(
                    labelText: 'Fecha de Nacimiento (Calendario)'),
                onTap: () async {
                  DateTime? fechaSeleccionada = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (fechaSeleccionada != null) {
                    _fechaNacimientoController.text =
                        fechaSeleccionada.toLocal().toString().split(' ')[0];
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  // Código para el botón "Guardar"
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmación'),
                        content: const Text(
                            '¿Está seguro de que desea guardar el registro?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Cerrar el cuadro de diálogo
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context)
                                  .pop(); // Cerrar el cuadro de diálogo

                              // Obtener los valores de los controladores
                              String nombreCliente =
                                  _nombreClienteController.text;
                              String apellidoCliente = _apellidoClienteController.text;
                              String cedula = _cedulaController.text;
                              String fechaNacimiento =
                                  _fechaNacimientoController.text;

                              // Validar que se hayan ingresado todos los campos
                              if (nombreCliente.isEmpty ||
                                  apellidoCliente.isEmpty ||
                                  cedula.isEmpty ||
                                  fechaNacimiento.isEmpty ||
                                  _selectedNacionalidad == null) {
                                // Mostrar un mensaje de error o realizar alguna acción en caso de campos faltantes
                                print('Por favor, complete todos los campos.');
                                return;
                              }

                              // Guardar el registro usando SharedPreferencesManager
                              await SharedPreferencesManager.guardarRegistro(
                                nombreCliente,
                                apellidoCliente,
                                cedula,
                                fechaNacimiento,
                                _selectedNacionalidad!,
                              );

                              // Mostrar un mensaje de éxito
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registro guardado con éxito.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );

                              // Restablecer los controladores después de registrar
                              _nombreClienteController.clear();
                              _apellidoClienteController.clear();
                              _cedulaController.clear();
                              _fechaNacimientoController.clear();
                              _selectedNacionalidad = null;
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Registrar Cliente'),
              ),
            ],
          ),
        ),
        ],
      ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}