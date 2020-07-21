import 'package:food4good_app/dto/supplier_info.dart';

class SuppliersService {
  SuppliersService();

  static List<String> searchByName(String queryName, List<SupplierInfoDTO> suppliersDTOList) {
    List<String> resultSuppliersIds = [];
    for (var supplierDTO in suppliersDTOList) {
      if (supplierDTO.restName.toLowerCase().contains(queryName.toLowerCase())) {
        resultSuppliersIds.add(supplierDTO.restId);
      }
    }
    return resultSuppliersIds;
  }
}
