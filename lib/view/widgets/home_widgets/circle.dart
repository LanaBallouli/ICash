import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';

class Circle extends StatelessWidget {
  final String name;
  final String icon;
  final double size;
  final void Function()? onPress;

  const Circle({
    super.key,
    required this.name,
    required this.icon,
    this.size = 70,
    this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LangController>(
      builder: (context, langController, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: _circleDecoration(),
              child: Center(
                child: IconButton(
                  onPressed: onPress,
                  icon: Image.asset(
                    icon,
                    height: size * 0.7,
                    width: size * 0.7,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 70,
              child: Text(
                name,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  BoxDecoration _circleDecoration() {
    return BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.white10,
          blurRadius: 10,
          offset: const Offset(0, 0),
        ),
      ],
      border: Border.all(width: 0.5, color: Colors.black12),
    );
  }
}
