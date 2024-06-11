import 'package:flutter/material.dart';
import 'package:petgo/service/TipoAnimalService.dart';
import 'package:petgo/model/TipoAnimal.dart';


class TelaTipoAnimal extends StatefulWidget {
  @override
  _TelaTipoAnimalState createState() => _TelaTipoAnimalState();
}

class _TelaTipoAnimalState extends State<TelaTipoAnimal> {
  late Future<List<TipoAnimal>> _tipoAnimal;
  final TipoAnimalService _tipoAnimalService = TipoAnimalService();

  final TextEditingController _tipoController = TextEditingController();

  TipoAnimal? _tipoAnimalAtual;


  @override
  void initState() {
    super.initState();
    _atualizarTipoAnimal();
  }

  void _atualizarTipoAnimal() {
    setState(() {
      _tipoAnimal = _tipoAnimalService.buscarTipoAnimals();
    });
  }

  void _mostrarFormulario({TipoAnimal? tipoAnimal}) {
    if (tipoAnimal != null) {
      _tipoAnimalAtual = tipoAnimal;
      _tipoController.text = tipoAnimal.tipo;

    } else {
      _tipoAnimalAtual = null;
      _tipoController.clear();

    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller:  _tipoController,
              decoration: InputDecoration(labelText: 'Tipo'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_tipoAnimalAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final tipo = _tipoController.text;

    if (_tipoAnimalAtual == null) {
      final novoTipoAnimal= TipoAnimal(tipo: tipo);
      await _tipoAnimalService.criarTipoAnimal(novoTipoAnimal);
    }
    else {
      final tipoAnimalAtualizado = TipoAnimal(
          id: _tipoAnimalAtual!.id,
          tipo: tipo,

      );
      await _tipoAnimalService.atualizarTipoAnimal(tipoAnimalAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarTipoAnimal();
  }

  void _deletarTipoAnimal(int id) async {
    try {
      await _tipoAnimalService.deletarTipoAnimal(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tipo animal deletado com sucesso!')));
      _atualizarTipoAnimal();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar o tipo animal: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIPO ANIMAL'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<TipoAnimal>>(
        future: _tipoAnimal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final tipoAnimal = snapshot.data![index];
                return ListTile(
                  title: Text('Tipo: ${tipoAnimal.tipo}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(tipoAnimal: tipoAnimal),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarTipoAnimal(tipoAnimal.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
