class Proprietario{
  final int? id;
  final String nome;
  final String cpf;
  final String cidade;
  final String estado;
  final String ncasa;
  final String rg;
  final String rua;
  final String telefone1;
  final String telefone2;




  Proprietario({this.id, required this.nome, required this.cpf, required this.cidade, required this.estado, required this.ncasa, required this.rg, required this.rua, required this.telefone1, required this.telefone2});

  factory Proprietario.fromJson(Map<String, dynamic> json) {
    return Proprietario(
      id: json['id'],
      nome: json['nome'],
      cpf: json ['cpf'],
      cidade: json ['cidade'],
      estado: json ['estado'],
      ncasa: json ['ncasa'],
      rg: json ['rg'],
      rua: json ['rua'],
      telefone1: json ['telefone1'],
      telefone2: json ['telefone2'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'cidade': cidade,
      'estado': estado,
      'ncasa': ncasa,
      'rg': rg,
      'rua': rua,
      'telefone1': telefone1,
      'telefone2': telefone2,
    };
  }
}