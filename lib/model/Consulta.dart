class Consulta{
  final int? id;
  final String data;
  final String descricao;
  final String hora;


  Consulta({this.id, required this.data, required this.descricao, required this.hora});

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      id: json['id'],
      data: json ['data'],
      descricao: json ['descricao'],
      hora: json ['hora'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'data': data,
      'descricao': descricao,
      'hora': hora
    };
  }
}