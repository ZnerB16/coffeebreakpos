class DTR{
  final int employeeID;
  final String timeIn;
  final String timeOut;
  final String date;
  String? employeeName = "";
  String? address = "";
  String? birthdate = "";

  DTR({
    required this.employeeID,
    required this.timeIn,
    required this.timeOut,
    required this.date,
    this.employeeName,
    this.address,
    this.birthdate
  }
      );
  factory DTR.fromSQfliteDatabase(Map<String, dynamic> map) => DTR(
    employeeID: map['employee_id']?.toInt() ?? 0,
    timeIn: map['time_in'] ?? '',
    timeOut: map['time_out'] ?? '',
    date: map['date'] ?? '',
  );
  factory DTR.joinedData(Map<String, dynamic> map) => DTR(
    employeeID: map['employee_id']?.toInt() ?? 0,
    timeIn: map['time_in'] ?? '',
    timeOut: map['time_out'] ?? '',
    date: map['date'] ?? '',
    employeeName: map["name"] ?? '',
    address: map["address"] ?? '',
    birthdate: map["birthdate"] ?? ''
  );
}