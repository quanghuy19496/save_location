import 'package:save_location/local/dao/address_location_dao.dart';
import 'package:save_location/local/model/address_location_model.dart';

class MainRepository {
  final AddressLocationDao _addressLocationDao = AddressLocationDao();

  void saveItemAddressLocationToDB(
      List<AddressLocationModel> addressLocations) {
    for (int i = 0; i < addressLocations.length; i++) {
      _addressLocationDao.insert(
        id: addressLocations[i].id,
        long: addressLocations[i].long,
        lat: addressLocations[i].lat,
      );
    }
  }

  Future<List<AddressLocationModel>?> getListCategoryFromDB() async {
    List<AddressLocationModel>? categoryLocal = [];
    final listAddressLocationDB = await _addressLocationDao.getLocationList();
    if (listAddressLocationDB == null) return null;
    categoryLocal = listAddressLocationDB
        .map(
          (obj) => AddressLocationModel(
            id: obj.id!,
            long: obj.long!,
            lat: obj.lat!,
          ),
        )
        .toList();

    return categoryLocal;
  }
}
