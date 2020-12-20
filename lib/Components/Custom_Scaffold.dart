//Import necessary packages
import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Constants.dart';

class CustomScaffold extends StatefulWidget {
  final Widget scaffoldBody;
  CustomScaffold({this.scaffoldBody});

  @override
  _CustomScaffoldState createState() =>
      _CustomScaffoldState(bodyFromHome: scaffoldBody);
}

class _CustomScaffoldState extends State<CustomScaffold>
    with SingleTickerProviderStateMixin {
  final bodyFromHome;
  _CustomScaffoldState({this.bodyFromHome});

  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Management Panel",
          style: AppBarFontStyle,
        ),
        centerTitle: true,
        backgroundColor: MainColor,
        elevation: 1.0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Home",
            ),
            Tab(
              text: "Seats",
            ),
          ],
          labelColor: MainFontsColor,
          labelStyle: AppBarLabeledBottomFontStyle,
          unselectedLabelColor: SubFontsColor,
          unselectedLabelStyle: AppBarUnLabeledBottomFontStyle,
          indicatorColor: SubMainColor,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      body: bodyFromHome,
    );
  }
}
