import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';

class QuantityUnitSelector extends StatelessWidget {
  const QuantityUnitSelector({
    super.key,
    required this.quantityText,
    required this.unitText,
    required this.onQuantityPressed,
    required this.onUnitPressed,
  });

  final String quantityText;
  final String unitText;
  final VoidCallback onQuantityPressed;
  final VoidCallback onUnitPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.choiceButtonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Quantity Button
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onQuantityPressed,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(quantityText, style: AppTextStyles.text14w600White),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.whiteTextColors),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            color: Colors.white24, // divider line
          ),
          // Unit Button
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: onUnitPressed,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(unitText, style: AppTextStyles.text14w600White),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
