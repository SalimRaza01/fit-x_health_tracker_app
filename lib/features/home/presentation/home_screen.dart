
import 'package:fit_x/features/home/category/overview.dart';
import 'package:fit_x/features/home/category/recovery.dart';
import 'package:fit_x/features/home/category/sleep.dart';
import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fit_x/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _tabController = TabController(length: 4, vsync: this);

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.backgroundLineartop,
                AppColor.backgroundLinearbottom,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 42, 51, 58),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: false,
                    indicatorWeight: .0,
                    indicatorPadding: EdgeInsets.all(3),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelStyle: TextStyle(fontSize: 10),
                    labelColor: const Color.fromARGB(255, 0, 0, 0),
                    unselectedLabelColor: const Color.fromARGB(
                      255,
                      146,
                      146,
                      146,
                    ),
                    tabs: [
                      Tab(text: 'OVERVIEW'),
                      Tab(text: 'WORKOUT'),
                      Tab(text: 'RECOVERY'),
                      Tab(text: "SLEEP"),
                    ],
                  ),
                ),
              ),
              // TabBarView content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children: [Overview(), Overview(), Recovery(), Sleep()],
                ),
              ),
            ],
          ),
        ),
       
      ),
    );
  }
}
