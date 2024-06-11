class Veterinario{
  final int? id;
  final String nome;
  final String cpf;
  final String rg;
  final String ncasa;
  final String cidade;
  final String estado;
  final String rua;
  final String telefone1;
  final String telefone2;
  final String crmv;



  Veterinario({this.id, required this.nome, required this.cpf, required this.rg, required this.ncasa, required this.cidade, required this.estado, required this.rua, required this.telefone1, required this.telefone2, required this.crmv});

  factory Veterinario.fromJson(Map<String, dynamic> json) {
    return Veterinario(
      id: json['id'],
      nome: json ['nome'],
      cpf: json ['cpf'],
      rg: json ['rg'],
      ncasa: json ['ncasa'],
      cidade: json ['cidade'],
      estado: json ['estado'],
      rua: json ['rua'],
      telefone1: json ['telefone1'],
      telefone2: json ['telefone2'],
      crmv: json ['crmv'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'ncasa': ncasa,
      'cidade': cidade,
      'estado': estado,
      'rua': rua,
      'telefone1': telefone1,
      'telefone2': telefone2,
      'crmv': crmv,
    };
  }
}