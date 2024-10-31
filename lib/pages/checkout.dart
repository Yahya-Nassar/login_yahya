// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_yahya/controls/services/order_service.dart';
import 'package:login_yahya/utils/app_colors.dart';
import 'package:login_yahya/utils/app_spaces.dart';
import 'package:login_yahya/utils/app_styles.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: _buildCheckoutContent(context),
    );
  }

  Widget _buildCheckoutContent(BuildContext context) {
    return Consumer<OrderService>(
      builder: (context, orderService, _) {
        return ClayContainer(
          color: AppColors.white,
          borderRadius: 15,
          spread: 1,
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              _buildHeader(context),
              const Divider(thickness: 0),
              if (orderService.getCheckoutDone) _buildSuccessMessage(),
              SpacesApp.spaceH_20,
              _buildSummary(orderService),
              SpacesApp.spaceH_20,
              _buildActionButton(context, orderService),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Checkout", style: StylesApp.titleDescStyle),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.cancel_presentation_outlined,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        ClayContainer(
          borderRadius: 250,
          color: AppColors.checkSucss,
          surfaceColor: AppColors.checkSucss,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.05,
          spread: 2,
          child: Icon(Icons.check, size: 40, color: AppColors.white),
        ),
        SpacesApp.spaceH_10,
        Text("Success", style: StylesApp.titleDescStyle),
        SpacesApp.spaceH_10,
        Text(
          "Your Order Has Been Placed Successfully",
          style: StylesApp.normalStyle,
        ),
      ],
    );
  }

  Widget _buildSummary(OrderService orderService) {
    final order = orderService.getOrder;
    return ClayContainer(
      color: AppColors.backGroundCategoryColor,
      borderRadius: 15,
      spread: 1,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSummaryRow("SubTotal", order.subTotal),
            const Divider(thickness: 0),
            _buildSummaryRow("Discount", 0.0),
            const Divider(thickness: 0),
            _buildSummaryRow("VAT", 0.0),
            const Divider(thickness: 0),
            _buildSummaryRow("Total", order.total, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    final style = isTotal ? StylesApp.totalStyle : StylesApp.calcStyle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value.toStringAsFixed(2), style: style),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, OrderService orderService) {
    return orderService.getIsLoading
        ? CircularProgressIndicator(color: AppColors.primaryColor)
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
              fixedSize: Size(
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            onPressed: () => _handleCheckout(context, orderService),
            child: Center(
              child: Text("Okay", style: StylesApp.itemNameStyle),
            ),
          );
  }

  Future<void> _handleCheckout(
      BuildContext context, OrderService orderService) async {
    await orderService.checkout();

    if (orderService.getCheckoutDone) {
      Future.delayed(const Duration(seconds: 1), () {
        orderService.clearOrder();
        Navigator.of(context).pop();
      });
    } else {
      print("Not Successfully");
    }
  }
}
