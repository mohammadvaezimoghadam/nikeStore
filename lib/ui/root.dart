import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikestore/ui/cart/cart.dart';
import 'package:nikestore/ui/home/home.dart';
import 'package:nikestore/ui/profile/profile.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScren extends StatefulWidget {
  const RootScren({Key? key}) : super(key: key);

  @override
  State<RootScren> createState() => _RootScrenState();
}

class _RootScrenState extends State<RootScren> {
  int selectedScreenIndex = homeIndex;
  List<int> history = [];

  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _carthKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _carthKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelecterTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelecterTabNavigatorState.canPop()) {
      currentSelecterTabNavigatorState.pop();
      return false;
    } else if (history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = history.last;
        history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'خانه'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart), label: 'سبد خرید'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
            ],
            currentIndex: selectedScreenIndex,
            onTap: (value) {
              setState(() {
                history.remove(selectedScreenIndex);
                history.add(selectedScreenIndex);
                selectedScreenIndex = value;
              });
            },
          ),
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, HomeScreen()),
              _navigator(_carthKey, cartIndex,CartScreen()),
              _navigator(_profileKey, profileIndex, ProfileScreen()),
            ],
          ),
        ),
        onWillPop: _onWillPop);
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentWidget==null && selectedScreenIndex!=index?Container(): Navigator(
      key: key,
      onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => Offstage(
                child: child,
                offstage: selectedScreenIndex != index,
              )),
    );
  }
}
