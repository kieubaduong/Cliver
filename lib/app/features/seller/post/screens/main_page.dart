import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class SellerPostHomeScreen extends StatefulWidget {
  const SellerPostHomeScreen({Key? key}) : super(key: key);

  @override
  State<SellerPostHomeScreen> createState() => _SellerPostHomeScreenState();
}

class _SellerPostHomeScreenState extends State<SellerPostHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: AppColors.primaryColor),
              ),
            ),
            tabs: [
              Tab(
                text: "My Posts".tr,
              ),
              Tab(
                text: "My Orders".tr,
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            SellerPostScreen(),
            SellerOrderScreen(),
          ],
        ),
      ),
    );
  }
}
