class PaginationModel {
  final int size;
  final int current;
  PaginationModel(this.size, this.current);

  PaginationModel copyWith({
    int? size,
    int? current,
  }) {
    return PaginationModel(
      size ?? this.size,
      current ?? this.current,
    );
  }
}
