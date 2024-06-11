import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petgo/model/TipoAnimal.dart';
class TipoAnimalService {
  static const String baseUrl = "http://10.121.138.114:8080/tipoAnimal/";

  Future<List<TipoAnimal>> buscarTipoAnimals() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List <dynamic> body= jsonDecode(response.body);
      return body.map((dynamic item) => TipoAnimal.fromJson(item)).toList();
    }
    else{
      throw Exception('Falha ao carregar o tipo do animal');
    }
  }

  Future<void> criarTipoAnimal(TipoAnimal tipoAnimal) async {
    final response = await http.post (
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(tipoAnimal.toJson()),
    );
    if (response.statusCode != 201){
      throw Exception('Falha ao criar o tipo do animal');
    }
  }

  Future <void> atualizarTipoAnimal(TipoAnimal tipoAnimal) async {
    final response = await http.put (
      Uri.parse('$baseUrl${tipoAnimal.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(tipoAnimal.toJson()),
    );
    if (response.statusCode != 200){
      throw Exception('Falha ao atualizar tipo do animal');
    }
  }

  Future <void> deletarTipoAnimal(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204){
      print('TipoAnimal deletado com sucesso');
    }
    else {
      print ('Erro ao deletar tipoAnimal: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar o tipo do animal');
    }
  }
}