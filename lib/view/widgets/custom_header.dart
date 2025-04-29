import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/lang_controller.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 235,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _headerGradientStartColor,
            _headerGradientEndColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: -70,
            child: _buildImage('assets/images/uuu.png', 170, 170),
          ),
          Positioned(
            right: -10,
            bottom: 0,
            top: 60,
            child: _buildImage('assets/images/background.png', 224, 224),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Consumer<LangController>(
                builder: (context, langController, child) {
                  String currentLangCode = langController.currentLangCode;
                  return IconButton(
                    onPressed: () {
                      langController.changeLang(langCode: currentLangCode == 'ar' ? 'en' : 'ar');
                    },
                    icon: Icon(Icons.language),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(String assetPath, double height, double width) {
    return Image.asset(
      assetPath,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.broken_image, size: height);
      },
    );
  }
}

const Color _headerGradientStartColor = Color(0xFFE7F4FF);
const Color _headerGradientEndColor = Color(0xFFB7E1FF);