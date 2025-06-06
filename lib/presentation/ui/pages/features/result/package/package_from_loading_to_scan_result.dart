class PackageFromLoadingToScanResult {
  final String id;
  final String description;
  final String recomDesc;
  final int acne;
  final int flex;
  final int wrinkle;
  List<Map<String, dynamic>> condition;

  PackageFromLoadingToScanResult({
    required this.condition,
    required this.recomDesc,
    required this.acne,
    required this.flex,
    required this.wrinkle,
    required this.id,
    required this.description,
  });
}
