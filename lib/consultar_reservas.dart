import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stay_hub/shared_preferences_manager.dart';

class ConsultarReservas extends StatefulWidget {
  @override
  _ConsultarReservasState createState() =>
      _ConsultarReservasState();
}

class _ConsultarReservasState extends State<ConsultarReservas> {
  List<String> _registros = [];
  String _cedulaBusqueda = '';
  int _indiceRegistro = 0;

@override
  void initState() {
    super.initState();
    _consultarRegistros();
  }

  Future<void> _consultarRegistros() async {
    List<String> registros = await SharedPreferencesManager.obtenerRegistros();
    setState(() {
      _registros = registros;
      _indiceRegistro = 0;
    });
  }

  List<String> _filtrarRegistrosPorCedula(String cedula) {
    return _registros
        .where((registro) => registro.contains('|$cedula|'))
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Reserva'),
        backgroundColor: Color(0xff3c4c44),
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Color(0xffe0bd6b), // Cambia el color del texto
        ),
      ),
      body: _registros.isEmpty
          ? Center(child: Text('No hay registros para mostrar.'))
          : _crearContenido(),
    );
  }
  Widget _crearContenido() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _crearInputCedula(),
          SizedBox(height: 20),
          _crearListadoClientes(),
        ],
      ),
    );
  }

  Widget _crearInputCedula() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        onChanged: (value) {
          setState(() {
            _cedulaBusqueda = value;
            _indiceRegistro = 0; // Reinicia el índice al cambiar la cédula
          });
        },
        decoration: InputDecoration(
          labelText: 'Ingrese la cédula del Cliente',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _crearListadoClientes() {
    List<String> clientes= _filtrarRegistrosPorCedula(_cedulaBusqueda);

    return clientes.isEmpty
        ? Center(child: Text('No hay reservas para la cédula ingresada.'))
        : Column(
            children: [
              _crearBotonesNavegacion(clientes.length),
              _crearDetalleClientes(clientes),
            ],
          );
  }

  Widget _crearBotonesNavegacion(int cantidadRegistros) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _indiceRegistro =
                  (_indiceRegistro - 1).clamp(0, cantidadRegistros - 1);
            });
          },
           style: ElevatedButton.styleFrom(
              primary: Color(
                  0xff3c4c44), // Cambia el color del botón cuando se presiona
              minimumSize: Size(100, 25), // Cambia el tamaño mínimo del botón
            ),
          child: Text('Anterior',
          style: TextStyle(
                fontSize: 20,
                color: Color(0xffe0bd6b), // Cambia el color del texto
              ),
              ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _indiceRegistro =
                  (_indiceRegistro + 1).clamp(0, cantidadRegistros - 1);
            });
          },
           style: ElevatedButton.styleFrom(
              primary: Color(
                  0xff3c4c44), // Cambia el color del botón cuando se presiona
              minimumSize: Size(100, 25), // Cambia el tamaño mínimo del botón
            ),
          child: Text('Siguiente',
          style: TextStyle(
                fontSize: 20,
                color: Color(0xffe0bd6b), // Cambia el color del texto
              ),
              ),
        ),
      ],
    );
  }
Widget _crearDetalleClientes(List<String> clientes) {
    if (_indiceRegistro < clientes.length) {
      String registro = clientes[_indiceRegistro];
      List<String> datos = registro.split('|');
      String nombreCliente = datos[0];
      String apellidoCliente = datos[1];
      String emailCliente = datos[2];
      String cedula = datos[3];
      String fechaNacimiento = datos[4];
      String nacionalidad = datos[5];
      //String tipoHabitacion=datos[6];
      DateTime fechaEntrada = datos.length > 7 ? DateTime.parse(datos[7]) : DateTime.now();
      DateTime fechaSalida = datos.length > 8? DateTime.parse(datos[8]) : DateTime.now();
      DateTime horaEntrada= datos.length > 9? DateTime.parse(datos[8]) : DateTime.now();
      Future<void> _consultarRegistros() async {
        List<String> registros = await SharedPreferencesManager.obtenerRegistros();
        setState(() {
          _registros = registros;
          _indiceRegistro = 0;
          });
      }
      return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre Cliente: $nombreCliente'),
            Text('Apellido Cliente: $apellidoCliente'),
            Text('Email: $emailCliente'),
            Text('Cédula: $cedula'),
            Text('Fecha Nacimiento: $fechaNacimiento'),
            Text('Nacionalidad: $nacionalidad'),
            //Text('Tipo de Habitacion Reservada: $tipoHabitacion'),
            Text('Fecha de Ingreso: ${_formatFecha(fechaEntrada)}'),
            Text('Hora de Ingreso: ${_formatHora(horaEntrada)}'),
            Text('Fecha de Salida: ${_formatFecha(fechaSalida)}'),
          ],
        ),
      ),
    );
    } else {
      return Center(child: Text('Registro no encontrado.'));
    }
  }
    String _formatFecha(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
    String _formatHora(DateTime dateTime) {
    // Formatear la hora según tus preferencias
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}