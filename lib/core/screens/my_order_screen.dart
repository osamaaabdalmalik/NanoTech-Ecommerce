import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/widgets/order_list.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/widgets/order_manufacturing_list.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/widgets/order_name_list.dart';
import 'package:nano_tech_cosmetic/main.dart';

class MyOrderScreen extends StatefulWidget {

  const MyOrderScreen({Key? key})
      : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.index =
        Get.previousRoute == AppPagesRoutes.productDetailsScreen ? 1 : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return globalUser != null && globalUser!.role != Role.customer
        ? Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(Get.width, Get.height * 0.1),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TabBar(
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.gray,
                  dividerColor: AppColors.black,
                  controller: tabController,
                  onTap: (value) {

                  },
                  isScrollable: false,
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.gray,
                          ),
                  labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primary,
                      ),
                  tabs: [
                    Tab(
                      text: AppTranslationKeys.cartOrders.tr,
                    ),
                    Tab(
                      text: AppTranslationKeys.specialOrders.tr,
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(controller: tabController, children: [
              OrderList(),
              if (globalUser!.role == Role.company)
                OrderManufacturingList(),
              if (globalUser!.role == Role.salon)
                OrderNameList()
            ]),
          )
        : OrderList();
  }
}
