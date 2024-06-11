import 'package:flutter/material.dart';
import 'package:petgo/telas/TelaConsulta.dart';
import 'package:petgo/telas/TelaPet.dart';
import 'package:petgo/telas/TelaProprietario.dart';
import 'package:petgo/telas/TelaTipoAnimal.dart';
import 'package:petgo/telas/TelaEspecialidade.dart';
import 'package:petgo/telas/TelaVeterinario.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PETGO'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
              child: Text(
                'Menu Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Consulta'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaConsulta()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.list),
              title: Text('Pet'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaPet()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Especialidade'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaEspecialidade()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Proprietario'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaProprietario()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Tipo Animal'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaTipoAnimal()),
                );
              },
            ),
              ListTile(
              leading: Icon(Icons.list),
              title: Text('Veterinário'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaVeterinario()),
                );
              },
            ),




          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('lib/ASSETS/capivara.jpg'),
            ),
            SizedBox(height: -0),
            Text(
              'Bem-vindo à Tela Principal',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}