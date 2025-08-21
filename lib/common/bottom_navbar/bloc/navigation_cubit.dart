import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(selectedIndex: 0));

  int _previousTabIndex = 0; // Track the previous tab

  void changeTab(int index) {
    _previousTabIndex =
        state.selectedIndex; // Store current tab before changing
    emit(NavigationState(selectedIndex: index));
  }

  void goToHome() {
    changeTab(0);
  }

  void goToProducts() {
    changeTab(1);
  }

  void goToAdd() {
    changeTab(2);
  }

  void goToNotifications() {
    changeTab(3);
  }

  void goToProfile() {
    changeTab(4);
  }

  void returnToPreviousTab() {
    // Return to the previously selected tab
    emit(NavigationState(selectedIndex: _previousTabIndex));
  }
}
