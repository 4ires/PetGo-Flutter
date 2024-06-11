import 'package:flutter/material.dart';
import 'package:petgo/service/EspecialidadeService.dart';
import 'package:petgo/model/Especialidade.dart';


class TelaEspecialidade extends StatefulWidget {
  @override
  _TelaEspecialidadeState createState() => _TelaEspecialidadeState();
}

class _TelaEspecialidadeState extends State<TelaEspecialidade> {
  late Future<List<Especialidade>> _especialidade;
  final EspecialidadeService _especialidadeService = EspecialidadeService();

  final TextEditingController _nomeController = TextEditingController();

  Especialidade? _especialidadeAtual;

  @override
  void initState() {
    super.initState();
    _atualizarEspecialidade();
  }

  void _atualizarEspecialidade() {
    setState(() {
      _especialidade = _especialidadeService.buscarEspecialidades();
    });
  }

  void _mostrarFormulario({Especialidade? especialidade}) {
    if (especialidade != null) {
      _especialidadeAtual = especialidade;
      _nomeController.text = especialidade.nome;
    } else {
      _especialidadeAtual = null;
      _nomeController.clear();
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
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_especialidadeAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;


    if (_especialidadeAtual == null) {
      final novaEspecialidade = Especialidade(nome: nome);
      await _especialidadeService.criarEspecialidade(novaEspecialidade);
    }
    else {
      final EspecialidadeAtualizada = Especialidade(
        id: _especialidadeAtual!.id,
        nome: nome,
      );
      await _especialidadeService.atualizarEspecialidade(EspecialidadeAtualizada);
    }

    Navigator.of(context).pop();
    _atualizarEspecialidade();
  }

  void _deletarEspecialidade(int id) async {
    try {
      await _especialidadeService.deletarEspecialidade(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Especialidade deletada com sucesso!')));
      _atualizarEspecialidade();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar a Especialidade: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialidade'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Especialidade>>(
        future: _especialidade,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final Especialidade = snapshot.data![index];
                return ListTile(
                  title: Text('Nome: ${Especialidade.nome}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(especialidade: Especialidade),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarEspecialidade(Especialidade.id!),
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
