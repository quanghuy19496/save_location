import 'package:flutter/material.dart';

/// BaseViewModel
abstract class BaseViewModel extends ChangeNotifier {
  static final List<ChangeNotifier> _notifierList = [];

  List<ChangeNotifier> get notifierList => _notifierList;

  bool _isEmptyListeners = false;

  late BuildContext context;

  void onInitViewModel(BuildContext context) {
    this.context = context;
  }

  void onBuildComplete({bool isNeedReBuildByOtherViewModel = true}) {
    if (isNeedReBuildByOtherViewModel && !_notifierList.contains(this)) {
      _notifierList.add(this);
    }
  }

  void updateCurrentUI() {
    notifyListeners();
  }

  void updateUI() {
    if (!_isEmptyListeners) {
      notifyListeners();
    }
    if (_notifierList.isEmpty) return;
    for (ChangeNotifier notifier in _notifierList) {
      if (notifier != this) {
        notifier.notifyListeners();
      }
    }
  }

  void clearNotifier() {
    _notifierList.clear();
  }

  @override
  void dispose() {
    _isEmptyListeners = true;
    super.dispose();
  }
}
