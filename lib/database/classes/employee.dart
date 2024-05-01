class Employee{
  final int employeeID;
  final String name;
  final String password;
  final String address;
  final String birthdate;

  Employee({
    required this.employeeID,
    required this.name,
    required this.password,
    required this.address,
    required this.birthdate
  }
      );
  factory Employee.fromSQfliteDatabase(Map<String, dynamic> map) => Employee(
    employeeID: map['employee_id']?.toInt() ?? 0,
    name: map['name'] ?? '',
    address: map['address'] ?? '',
    birthdate: map['birthdate'] ?? '',
    password: map['password'] ?? '',
  );
}