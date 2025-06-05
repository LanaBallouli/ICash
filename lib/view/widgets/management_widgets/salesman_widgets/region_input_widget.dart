import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/region.dart';

class RegionInputWidget extends StatelessWidget {
  final Region? selectedRegion;
  final String hintText;
  final List<Region> regions;
  final Function(Region?)? onChange;
  final String? err;

  const RegionInputWidget({
    super.key,
    this.selectedRegion,
    required this.hintText,
    required this.regions,
    this.onChange,
    this.err,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.region,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Consumer<ManagementController>(
            builder: (context, managementController, _) {
              final error = managementController.errors['region'];
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: DropdownButtonFormField<Region>(
                      hint: Text(hintText),
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                      value: selectedRegion,
                      items: regions.map((region) {
                        return DropdownMenuItem<Region>(
                          value: region,
                          child: Text(region.name),
                        );
                      }).toList(),
                      onChanged: onChange ??
                          (value) {
                            managementController.setSelectedRegion(
                                value, context);
                          },
                      validator: (value) {
                        if (error != null) return error;
                        return null;
                      },
                      dropdownColor: Colors.white,
                      isExpanded: true,
                    ),
                  ),
                ),
              );
            },
          ),
          Consumer<ManagementController>(
            builder: (context, managementController, child) {
              if (err != null ||
                  managementController.errors['region'] != null) {
                return Text(
                  err ?? managementController.errors['region']!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                );
              }
              else {
                return SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
