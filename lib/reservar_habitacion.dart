import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class reservar_habitacion extends StatefulWidget {
  @override
  _reservar_habitacion_state createState() => _reservar_habitacion_state();
}

class _reservar_habitacion_state extends State<reservar_habitacion>{
  DateTime _fechaSeleccionada = DateTime.now();
  /*String? _selectedTipo;
  List<String> tipo = [
    'Simple',
    'Doble',
    'Matrimonial'
  ];*/
  String? _selectedTipo;
Map<String, String> tipo= {
  'Simple': 'assets/simple.png',
  'Doble': 'assets/doble.png',
  'Matrimonial': 'assets/matrimonial.png',
};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar Habitación'),
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
            _crearSelectorReserva(),
            SizedBox(height: 20),
            _crearSelectorFecha(),
            SizedBox(height: 20),
            _crearSelectorHora(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _confirmarReserva();
              },
              child: Text('Reservar'),
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

  Widget _crearSelectorReserva() {
    // Implementa la lógica para seleccionar el servicio aquí
    return Container();
  }

  Widget _crearSelectorFecha() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text('Fecha de la Reserva: ${_fechaSeleccionada.toLocal()}'),
        ),
        ElevatedButton(
          onPressed: () {
            _seleccionarFecha();
          },
          child: Text('Seleccionar Fecha'),
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
            Text('Hora de la reserva: ${_formatHora(_fechaSeleccionada)}'),
          ],
        ),
      ),
      ElevatedButton(
        onPressed: () {
          _seleccionarHora();
        },
        child: Text('Seleccionar Hora'),
      ),
    ],
  );
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
      pickedTime.hour,
      pickedTime.minute,
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
        _fechaSeleccionada = pickedDate;
      });
    }
  }

  void _confirmarReserva() {
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