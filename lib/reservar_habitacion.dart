import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stay_hub/shared_preferences_manager.dart';

class reservar_habitacion extends StatefulWidget {
  @override
  _reservar_habitacion_state createState() => _reservar_habitacion_state();
}

class _reservar_habitacion_state extends State<reservar_habitacion> {
  DateTime _fechaSeleccionada = DateTime.now();
  DateTime _fechaSeleccionada1 = DateTime.now();
  String? _selectedTipo;
  Map<String, String> tipo = {
    'Simple': 'assets/simple.png',
    'Doble': 'assets/doble.png',
    'Matrimonial': 'assets/matrimonial.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar Habitación'),
        backgroundColor: Color(0xff3c4c44),
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Color(0xffe0bd6b), // Cambia el color del texto
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _crearInputCedula(),
            SizedBox(height: 20),
            _crearSelectorHabitacion(),
            SizedBox(height: 20),
            _crearSelectorFecha(),
            SizedBox(height: 20),
            _crearSelectorHora(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _confirmarReserva();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(
                    0xff3c4c44), // Cambia el color del botón cuando se presiona
                minimumSize: Size(100, 25), // Cambia el tamaño mínimo del botón
              ),
              child: Text(
                'Reservar',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffe0bd6b), // Cambia el color del texto
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearInputCedula() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        decoration: InputDecoration(
          labelText: 'Ingrese la cédula del cliente',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _crearSelectorHabitacion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          hint: const Text('Seleccione el Tipo de Habitación'),
          style: TextStyle(fontSize: 20,
          color:Color(0xff3c4c44), // Cambia el color del texto
        ),
          value: _selectedTipo,
          onChanged: (String? value) {
            setState(() {
              _selectedTipo = value;
            });
          },
          items: tipo.keys.map<DropdownMenuItem<String>>((String tipoKey) {
            return DropdownMenuItem<String>(
              value: tipoKey,
              child: Text(tipoKey),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        _selectedTipo != null
            ? Image.asset(
                tipo[_selectedTipo!]!,
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              )
            : Container(),
      ],
    );
  }

  Widget _crearSelectorFecha() {
    return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text('Fecha de Ingreso : ${_formatFecha(_fechaSeleccionada)}'),
          ),
          ElevatedButton(
            onPressed: () {
              _seleccionarFecha();
            },
            style: ElevatedButton.styleFrom(
              primary: Color(
                  0xff3c4c44), // Cambia el color del botón cuando se presiona
              minimumSize: Size(100, 25), // Cambia el tamaño mínimo del botón
            ),
            child: Text(
              'Seleccionar Fecha',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffe0bd6b), // Cambia el color del texto
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fecha de Salida : ${_formatFecha1(_fechaSeleccionada1)}'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _seleccionarFecha1();
            },
            style: ElevatedButton.styleFrom(
              primary: Color(
                  0xff3c4c44), // Cambia el color del botón cuando se presiona
              minimumSize: Size(100, 25), // Cambia el tamaño mínimo del botón
            ),
            child: Text(
              'Seleccionar Fecha',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffe0bd6b), // Cambia el color del texto
              ),
            ),
          ),
        ],
      ),
    ],
  );
  }

  Widget _crearSelectorHora() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hora de Ingreso: ${_formatHora(_fechaSeleccionada)}'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _seleccionarHora();
          },
          style: ElevatedButton.styleFrom(
            primary: Color(
                0xff3c4c44), // Cambia el color del botón cuando se presiona
            minimumSize: Size(100, 25), // Cambia el tamaño mínimo del botón
          ),
          child: Text('Seleccionar Hora',
          style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffe0bd6b), // Cambia el color del texto
          ),
          ),
        ),
      ],
    );
  }

  String _formatFecha(DateTime dateTime) {
  // Formatear la fecha según tus preferencias
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatFecha1(DateTime dateTime) {
  // Formatear la fecha según tus preferencias
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatHora(DateTime dateTime) {
    // Formatear la hora según tus preferencias
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _seleccionarHora() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      DateTime selectedDateTime = DateTime(
        _fechaSeleccionada.year,
        _fechaSeleccionada.month,
        _fechaSeleccionada.day,
      );

      setState(() {
        _fechaSeleccionada = selectedDateTime;
      });
    }
  }

  void _seleccionarFecha() async {
    DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: _fechaSeleccionada,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null && pickedDate != _fechaSeleccionada) {
    setState(() {
      // Ajusta la fecha para eliminar la hora, minutos y segundos
      _fechaSeleccionada = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
    });
  }  
  }

  void _seleccionarFecha1() async {
    DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: _fechaSeleccionada1,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null && pickedDate != _fechaSeleccionada1) {
    setState(() {
      // Ajusta la fecha para eliminar la hora, minutos y segundos
      _fechaSeleccionada1 = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
    });
  }
  
  }

  void _confirmarReserva() async {
    // Guarda la información de la reserva en SharedPreferences
  String infoReserva = '$_selectedTipo|$_fechaSeleccionada|$_fechaSeleccionada1';
  await SharedPreferencesManager.guardarReserva(infoReserva);

  // Muestra un diálogo de confirmación
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reserva Confirmada'),
        content: Text('¡Habitación reservada con éxito!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Puedes agregar más lógica aquí si es necesario
              Navigator.of(context).pop();
            },
            child: Text('Aceptar'),
          ),
        ],
      );
    },
  );
  }
}
