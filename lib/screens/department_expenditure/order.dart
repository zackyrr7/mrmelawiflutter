class Order {
  final OrderColumn column;
  final OrderType type;

  Order({required this.column, required this.type});

  Order copyWith({
    OrderColumn? column,
    OrderType? type,
  }) {
    return Order(
      column: column ?? this.column,
      type: type ?? this.type,
    );
  }
}

enum OrderColumn {
  kdSkpd,
  anggaran,
  realisasi;

  @override
  String toString() {
    switch (this) {
      case OrderColumn.kdSkpd:
        return "Kode SKPD";
      case OrderColumn.anggaran:
        return "Anggaran";
      case OrderColumn.realisasi:
        return "Realisasi";
      default:
        throw Exception("Undefined Enum Value");
    }
  }
}

enum OrderType {
  asc,
  desc;

  @override
  String toString() {
    switch (this) {
      case OrderType.asc:
        return "asc";
      case OrderType.desc:
        return "desc";
      default:
        throw Exception("Unknown type of OrderType");
    }
  }
}
