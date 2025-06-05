class PackageFromLoadingToScanResult {
  final String id;
  final String description;
  final String recomDesc;
  List<Map<String, dynamic>> condition;

  PackageFromLoadingToScanResult({
    required this.condition,
    required this.recomDesc,
    required this.id,
    required this.description,
  });
}
