import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:save_location/base/base_view_model.dart';
import 'package:save_location/local/dao/address_location_dao.dart';
import 'package:save_location/local/model/address_location_model.dart';
import 'package:workmanager/workmanager.dart';

import 'local/app_database.dart';
import 'local/repositories/main_repository.dart';

class MainViewModel extends BaseViewModel {
  final MainRepository _mainRepository = MainRepository();

  List<AddressLocationModel> addressLocations = [];

  // Task name
  static const fetchBackground = "BackgroundLocation";

  // Identifier task background
  static const uniqueNameBackground = "UniqueNameBackground";
  Position? position;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await _initDatabase();
    await _initWorkManager();
    getListAddressLocationFromDB();
  }

  void _callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case fetchBackground:
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          // insert address location list to db
          addressLocations.add(AddressLocationModel(
              id: DateTime.now().toString(),
              long: position!.longitude.toString(),
              lat: position!.latitude.toString()));
          _mainRepository.saveItemAddressLocationToDB(addressLocations);
          break;
      }
      return Future.value(true);
    });
  }

  Future<void> _initWorkManager() async {
    Workmanager().initialize(
      _callbackDispatcher,
      isInDebugMode: true,
    );

    Workmanager().registerPeriodicTask(
      uniqueNameBackground,
      fetchBackground,
      // Update location every 30 minutes
      frequency: const Duration(minutes: 30),
    );
  }

  Future<void> _initDatabase() async {
    await Future.wait(
      [
        AppDatabase().onInit().then((database) async {
          if (database != null) {
            AddressLocationDao().init();
          }

          return database;
        }),
      ],
    );
  }

  /// Get list Address Location from DB
  Future<void> getListAddressLocationFromDB() async {
    final res = await _mainRepository.getListCategoryFromDB();
    if (res != null) {
      addressLocations = res;
    }
    updateCurrentUI();
  }
}
