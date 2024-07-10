class Horaire {
  final int id;
  final String startTime;
  final String endTime;
  final int employeeId;
  final String commentaire;
  final DateTime date;

  Horaire({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.employeeId,
    required this.commentaire,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime,
      'end_time': endTime,
      'employee_id': employeeId,
      'commentaire': commentaire,
      'date': date.toIso8601String(),
    };
  }
}
