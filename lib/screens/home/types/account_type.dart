enum AccountType {
  pendapatan,
  belanja,
  pembiayaan;

  @override
  String toString() {
    switch (this) {
      case AccountType.pendapatan:
        return "Pendapatan";
      case AccountType.belanja:
        return "Belanja";
      case AccountType.pembiayaan:
        return "Pembiayaan";
      default:
        return "";
    }
  }
}
