class ProductFilter {
  List<Map<String, dynamic>> emptyFilter(List<Map<String, dynamic>> allProducts) {

    return allProducts;
  }

  List<Map<String, dynamic>> sortAlphabeticallyAsc(List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) => a['name'].compareTo(b['name']));
    return allProducts;
  }

  List<Map<String, dynamic>> sortAlphabeticallyDesc(List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) => b['name'].compareTo(a['name']));
    return allProducts;
  }

  List<Map<String, dynamic>> sortByQuantityDesc(List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) => b['quantity'].compareTo(a['quantity']));
    return allProducts;
  }

  List<Map<String, dynamic>> sortByQuantityAsc(List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) => a['quantity'].compareTo(b['quantity']));
    return allProducts;
  }
}