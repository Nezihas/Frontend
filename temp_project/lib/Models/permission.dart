class Permission {
  int id;
  int idemployee;
  String commentaire;
  DateTime date;
  String statut;

  Permission({
    required this.id,
    required this.idemployee,
    required this.commentaire,
    required this.date,
    required this.statut,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'] ?? 0,
      idemployee: json['idemployee'] ?? 0,
      commentaire: json['commentaire'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      statut: json['statut'] ?? 'en cours',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idemployee': idemployee,
      'commentaire': commentaire,
      'date': date.toIso8601String(),
      'statut': statut,
    };
  }
}
