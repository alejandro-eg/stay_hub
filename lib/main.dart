import 'package:flutter/material.dart';
import 'package:stay_hub/registrar_cliente.dart';
import 'package:stay_hub/reservar_habitacion.dart';
import 'package:stay_hub/consultar_reservas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StayHub',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: const BienvenidaScreen(),
    );
  }
}

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenidos a StayHub'),
      ),
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/stayhub.png',
              fit: BoxFit.cover,
            ),
            Align(
             alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff3c4c44), // Cambia el color del botón cuando se presiona
                  minimumSize: Size(200, 50), // Cambia el tamaño mínimo del botón
              ),
              child: const Text('Ingresar',
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xffe0bd6b), // Cambia el color del texto
                ),
              ),
              ),
            ),
          ),
          ],
        ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StayHub'),
      ),
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/stayhub.png',
              fit: BoxFit.cover,
            ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrarCliente(),
                  ),
                );
              },
              child: const Text('Registrate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultarReservas(),
                  ),
                );
              },
              child: const Text('Consultar Reservas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservarHabitacion(),
                  ),
                );
              },
              child: const Text('Reservar'),
            
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}