import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../main_widgets/input_widget.dart';

class UploadPhotos extends StatelessWidget {
  final String title;
  final String photoType; // Identifier for the type of photo

  const UploadPhotos({
    super.key,
    required this.title,
    required this.photoType,
  });

  @override
  Widget build(BuildContext context) {
    final managementController = Provider.of<ManagementController>(context);
    final langController = Provider.of<LangController>(context, listen: false);

    // Get the list of photos based on the photoType
    List<String> photos = managementController.getPhotosByType(photoType);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.getFontStyle(
            langController,
            color: Color(0xFF6C7278),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        InputWidget(
          textEditingController: TextEditingController(
              text: "Upload Photos (${photos.length}/2)"),
          readOnly: true,
          suffixIcon: Icon(Icons.camera_alt_outlined),
          onTap: () {
            managementController.pickImage(photoType); // Pass photoType
          },
        ),
        if (managementController.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              managementController.errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
              ),
            ),
          ),
        SizedBox(height: 15.h),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: photos.map((base64String) {
            return Stack(
              children: [
                Image.memory(
                  base64Decode(base64String),
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      managementController.removeImage(base64String, photoType); // Pass photoType
                    },
                    child: Icon(Icons.close, color: Colors.red, size: 18.sp),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}