import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_location/base/base_view.dart';
import 'package:save_location/local/model/address_location_model.dart';

import 'main_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends BaseView {
  const MyApp({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends BaseViewState<MyApp, MainViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MainViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return ChangeNotifierProvider<MainViewModel>(
      create: (_) => viewModel,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Get GPS location',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Selector<MainViewModel, List<AddressLocationModel>>(
                selector: (_, viewModel) => viewModel.addressLocations,
                shouldRebuild: (pre, next) => true,
                builder: (_, addressLocation, __) {
                  return ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: addressLocation.length,
                    itemBuilder: (context, index) {
                      final item = addressLocation[index];

                      return _buildItemAddress(item);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemAddress(AddressLocationModel addressLocation) {
    return Column(
      children: [
        Text("Longitude: ${addressLocation.long}",
            style: const TextStyle(fontSize: 20)),
        Text(
          "Latitude: ${addressLocation.long}",
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
