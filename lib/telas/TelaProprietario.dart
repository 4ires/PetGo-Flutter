import 'package:flutter/material.dart';
import 'package:petgo/service/proprietarioService.dart';
import 'package:petgo/model/Proprietario.dart';


class TelaProprietario extends StatefulWidget {
  @override
  _TelaProprietarioState createState() => _TelaProprietarioState();
}

class _TelaProprietarioState extends State<TelaProprietario> {
  late Future<List<Proprietario>> _proprietario;
  final ProprietarioService _proprietarioService = ProprietarioService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _nCasaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _telefone2Controller = TextEditingController();


  Proprietario? _proprietarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarProprietario();
  }

  void _atualizarProprietario() {
    setState(() {
      _proprietario = _proprietarioService.buscarProprietarios();
    });
  }

  void _mostrarFormulario({Proprietario? proprietario}) {
    if (proprietario != null) {
      _proprietarioAtual = proprietario;
      _nomeController.text = proprietario.nome;
      _cpfController.text = proprietario.cpf;
      _rgController.text = proprietario.rg;
      _estadoController.text = proprietario.estado;
      _cidadeController.text = proprietario.cidade;
      _ruaController.text = proprietario.rua;
      _nCasaController.text = proprietario.ncasa;
      _telefoneController.text = proprietario.telefone1;
      _telefone2Controller.text = proprietario.telefone2;
    } else {
      _proprietarioAtual = null;
      _nomeController.clear();
      _cpfController.clear();
      _rgController.clear();
      _estadoController.clear();
      _cidadeController.clear();
      _ruaController.clear();
      _nCasaController.clear();
      _telefoneController.clear();
      _telefone2Controller.clear();

    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
          left: 10,
          right: 10,
        ),
        child:
          ListView (
            children: <Widget>[
            TextField(
              controller:  _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'Cpf'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _rgController,
              decoration: InputDecoration(labelText: 'Rg'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _estadoController,
              decoration: InputDecoration(labelText: 'Estado'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _ruaController,
              decoration: InputDecoration(labelText: 'Rua'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _nCasaController,
              decoration: InputDecoration(labelText: 'Número da casa'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _telefone2Controller,
              decoration: InputDecoration(labelText: 'Telefone 2'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_proprietarioAtual == null ? 'Criar' : 'Atualizar'),
            ),

        ],
      ),

      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final cpf = _cpfController.text;
    final rg = _rgController.text;
    final estado = _estadoController.text;
    final cidade = _cidadeController.text;
    final rua = _ruaController.text;
    final nCasa = _nCasaController.text;
    final telefone = _telefoneController.text;
    final telefone2 = _telefone2Controller.text;

    if (_proprietarioAtual == null) {
      final novoProprietario= Proprietario(nome: nome, cpf: cpf, rg: rg, estado: estado, cidade: cidade, rua: rua, ncasa: nCasa, telefone1: telefone, telefone2: telefone2);
      await _proprietarioService.criarProprietario(novoProprietario);
    }
    else {
      final proprietarioAtualizado = Proprietario(
        id: _proprietarioAtual!.id,
        nome: nome,
        cpf: cpf,
        rg: rg,
        estado: estado,
        cidade: cidade,
        rua: rua,
        ncasa: nCasa,
        telefone1: telefone,
        telefone2: telefone2

      );
      await _proprietarioService.atualizarProprietario(proprietarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarProprietario();
  }

  void _deletarProprietario(int id) async {
    try {
      await _proprietarioService.deletarProprietario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proprietário deletado com sucesso!')));
      _atualizarProprietario();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar o proprietário: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROPRIETÁRIO'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Proprietario>>(
        future: _proprietario,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final proprietario = snapshot.data![index];
                return ListTile(
                  title: Text('Nome: ${proprietario.nome}'),
                  subtitle: Text('cpf: ${proprietario.cpf}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(proprietario: proprietario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarProprietario(proprietario.id!),
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
