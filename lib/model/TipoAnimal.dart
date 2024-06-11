class TipoAnimal{
  final int? id;
  final String tipo;




  TipoAnimal({this.id, required this.tipo});

  factory TipoAnimal.fromJson(Map<String, dynamic> json) {
    return TipoAnimal(
      id: json['id'],
      tipo: json ['tipo'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'tipo': tipo,

    };
  }
}