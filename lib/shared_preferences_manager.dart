import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String _reservaKey = 'reserva';

  // Guarda la información de la reserva en SharedPreferences
  static Future<void> guardarReserva(String infoReserva) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_reservaKey, infoReserva);
  }

  // Obtiene la información de la reserva almacenada en SharedPreferences
  static Future<String?> obtenerReserva() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_reservaKey);
  }

  static Future<void> guardarRegistro(
    String nombreCliente,
    String apellidoCliente,
    String emailCliente,
    String cedula,
    String fechaNacimiento,
    String nacionalidad,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> registros = prefs.getStringList('registros') ?? [];
    String nuevoRegistro =
        '$nombreCliente|$apellidoCliente|$emailCliente|$cedula|$fechaNacimiento|$nacionalidad';
    registros.add(nuevoRegistro);
    prefs.setStringList('registros', registros);
  }

  static Future<List<String>> obtenerRegistros() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('registros') ?? [];
  }

  static Future<void> agendarCita(
      String codigoCliente, String tipoServicio, String fecha) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> citas = prefs.getStringList('citas') ?? [];
    String nuevaCita = '$codigoCliente|$tipoServicio|$fecha';
    citas.add(nuevaCita);
    prefs.setStringList('citas', citas);
  }

  static Future<List<String>> obtenerCitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('citas') ?? [];
  }

  static Future<void> eliminarRegistroPorCedula(String cedula) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> registros = prefs.getStringList('registros') ?? [];

    registros.removeWhere((registro) => registro.contains('|$cedula|'));

    await prefs.setStringList('registros', registros);
  }
}