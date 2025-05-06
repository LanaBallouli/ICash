import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/model/users.dart';

class ClientsWidget extends StatelessWidget {
  final Client client;
  final int index;

  const ClientsWidget({super.key, required this.client, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
