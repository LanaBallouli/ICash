import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/camera_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../main_widgets/input_widget.dart';

class UploadPhotos extends StatelessWidget {
  final String title;
  final String photoType;

  const UploadPhotos({
    super.key,
    required this.title,
    required this.photoType,
  });

  @override
  Widget build(BuildContext context) {
    final cameraController = Provider.of<CameraController>(context);
    final langController = Provider.of<LangController>(context, listen: false);

    // Get the list of photos based on the photoType
    List<String> photos = cameraController.getPhotosByType(photoType);

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
              text: "${AppLocalizations.of(context)!.upload_photos} (${photos.length}/2)"),
          readOnly: true,
          suffixIcon: Icon(Icons.camera_alt_outlined),
          onTap: () {
            cameraController.pickImage(photoType); // Pass photoType
          },
        ),
        if (cameraController.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              cameraController.errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
              ),
            ),
          ),
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
                      cameraController.removeImage(base64String, photoType); // Pass photoType
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