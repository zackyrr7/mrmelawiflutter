enum ValueType {
  anggaran,
  realisasi;

  bool get isAnggaran => this == ValueType.anggaran;
  bool get isRealisasi => this == ValueType.realisasi;

  @override
  String toString() {
    switch (this) {
      case ValueType.anggaran:
        return "Anggaran";
      case ValueType.realisasi:
        return "Realisasi";
      default:
        throw Exception("Unknown type of ValueType");
    }
  }
}
