import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/stayhub.png',
                height: 200,
                width: 200), // Asegúrate de tener tu logo en la carpeta assets
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de registro de mascotas
                Navigator.pushNamed(context, '/registrar_cliente');
              },
              child: const Text('Registrar Cliente'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de consulta de registro
                Navigator.pushNamed(context, '/consultar_registro');
              },
              child: const Text('Consultar Registro'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de agendar cita
                Navigator.pushNamed(context, '/agendar_cita');
              },
              child: const Text('Agendar Cita'),
            ),
          ],
        ),
      ),
    );
  }
}