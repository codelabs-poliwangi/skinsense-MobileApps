class PackageFromLoadingToScanResult {
  final String id;
  final String description;
  List<Map<String, dynamic>> condition;

  PackageFromLoadingToScanResult({
    required this.condition,
    required this.id,
    required this.description,
  });
}
