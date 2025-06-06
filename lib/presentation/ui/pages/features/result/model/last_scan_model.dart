class LastScanModel {
  final DateTime? date;
  final int wringkle;
  final int acne;
  final int flex;

  LastScanModel({
    required this.date,
    required this.wringkle,
    required this.acne,
    required this.flex,
  });

  // From JSON
  factory LastScanModel.fromJson(Map<String, dynamic> json) {
    return LastScanModel(
      date: DateTime.parse(json['date']),
      wringkle: json['wringkle'] ?? 0,
      acne: json['acne'] ?? 0,
      flex: json['flex'] ?? 0,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'wringkle': wringkle,
      'acne': acne,
      'flex': flex,
    };
  }
}
