class Employee {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final DateTime dateOfBirth;
  final DateTime dateOfHire;
  final String? gender;

  Employee({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
    required this.dateOfBirth,
    required this.dateOfHire,
    this.gender,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    print("Parsing Employee from JSON: $json");  // Debug print
    return Employee(
      id: json['id'],
      firstname: json['firstName'],
      lastname: json['lastName'],
      email: json['email'],
      telephone: json['telephone'].toString(),  // Ensure telephone is a String
      dateOfBirth: DateTime.fromMillisecondsSinceEpoch(json['dateOfBirth']),  // Convert timestamp to DateTime
      dateOfHire: DateTime.fromMillisecondsSinceEpoch(json['dateOfHire']),  // Convert timestamp to DateTime
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstname,
      'lastName': lastname,
      'email': email,
      'telephone': telephone,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,  // Convert DateTime to timestamp
      'dateOfHire': dateOfHire.millisecondsSinceEpoch,  // Convert DateTime to timestamp
      'gender': gender,
    };
  }
}
