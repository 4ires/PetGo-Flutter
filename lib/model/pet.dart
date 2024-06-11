class Pet{
  final int? id;
  final String cor;
  final String dt_nascimento;
  final String ndocumento;
  final String nome;
  final String raca;
  final String tipo_animal;


  Pet({this.id, required this.cor, required this.dt_nascimento, required this.ndocumento, required this.nome, required this.raca, required this.tipo_animal});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      cor: json ['cor'],
      dt_nascimento: json ['dt_nascimento'],
      ndocumento: json ['ndocumento'],
      nome: json ['ndocumento'],
      raca: json ['ndocumento'],
      tipo_animal: json ['ndocumento'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'cor': cor,
      'dt_nascimento': dt_nascimento,
      'ndocumento': ndocumento,
      'nome': nome,
      'raca': raca,
      'tipo_animal': tipo_animal
    };
  }
}