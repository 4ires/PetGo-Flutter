import 'package:flutter/material.dart';
import 'package:petgo/service/veterinarioService.dart';
import 'package:petgo/model/Veterinario.dart';


class TelaVeterinario extends StatefulWidget {
  @override
  _TelaVeterinarioState createState() => _TelaVeterinarioState();
}

class _TelaVeterinarioState extends State<TelaVeterinario> {
  late Future<List<Veterinario>> _veterinario;
  final VeterinarioService _veterinarioService = VeterinarioService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _nCasaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _telefone2Controller = TextEditingController();
  final TextEditingController _crmvController = TextEditingController();


  Veterinario? _veterinarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarVeterinario();
  }

  void _atualizarVeterinario() {
    setState(() {
      _veterinario = _veterinarioService.buscarVeterinarios();
    });
  }

  void _mostrarFormulario({Veterinario? veterinario}) {
    if (veterinario != null) {
      _veterinarioAtual = veterinario;
      _nomeController.text = veterinario.nome;
      _cpfController.text = veterinario.cpf;
      _rgController.text = veterinario.rg;
      _estadoController.text = veterinario.estado;
      _cidadeController.text = veterinario.cidade;
      _ruaController.text = veterinario.rua;
      _nCasaController.text = veterinario.ncasa;
      _telefoneController.text = veterinario.telefone1;
      _telefone2Controller.text = veterinario.telefone2;
      _crmvController.text = veterinario.crmv;

    } else {
      _veterinarioAtual = null;
      _nomeController.clear();
      _cpfController.clear();
      _rgController.clear();
      _estadoController.clear();
      _cidadeController.clear();
      _ruaController.clear();
      _nCasaController.clear();
      _telefoneController.clear();
      _telefone2Controller.clear();
      _crmvController.clear();

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
            TextField(
              controller: _crmvController,
              decoration: InputDecoration(labelText: 'CRMV'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_veterinarioAtual == null ? 'Criar' : 'Atualizar'),
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
    final crmv = _crmvController.text;

    if (_veterinarioAtual == null) {
      final novoVeterinario= Veterinario(nome: nome, cpf: cpf, rg: rg, estado: estado, cidade: cidade, rua: rua, ncasa: nCasa, telefone1: telefone, telefone2: telefone2, crmv: crmv);
      await _veterinarioService.criarVeterinario(novoVeterinario);
    }
    else {
      final veterinarioAtualizado = Veterinario(
          id: _veterinarioAtual!.id,
          nome: nome,
          cpf: cpf,
          rg: rg,
          estado: estado,
          cidade: cidade,
          rua: rua,
          ncasa: nCasa,
          telefone1: telefone,
          telefone2: telefone2,
          crmv: crmv

      );
      await _veterinarioService.atualizarVeterinario(veterinarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarVeterinario();
  }

  void _deletarVeterinario(int id) async {
    try {
      await _veterinarioService.deletarVeterinario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veterinário deletado com sucesso!')));
      _atualizarVeterinario();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar o veterinario: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VETERINÁRIO'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Veterinario>>(
        future: _veterinario,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final veterinario = snapshot.data![index];
                return ListTile(
                  title: Text('Nome: ${veterinario.nome}'),
                  subtitle: Text('cpf: ${veterinario.cpf}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(veterinario: veterinario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarVeterinario(veterinario.id!),
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
