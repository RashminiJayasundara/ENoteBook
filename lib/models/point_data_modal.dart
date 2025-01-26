class PointData {
  final double dx;
  final double dy;

  PointData({required this.dx, required this.dy});

  Map<String, dynamic> toJson() => {'dx': dx, 'dy': dy};

  factory PointData.fromJson(Map<String, dynamic> json) {
    return PointData(
      dx: json['dx'],
      dy: json['dy'],
    );
  }
}
