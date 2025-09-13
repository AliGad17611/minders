import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/manger/cubit/crating_habit_cubit.dart';

class QuantityPickerModal extends StatelessWidget {
  const QuantityPickerModal({super.key});

  static final List<String> quantities = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];

  static void show(BuildContext context, CreatingHabitCubit cubit) {
    final TextEditingController customQuantityController =
        TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.choiceButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 350,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Select Quantity",
                  style: AppTextStyles.text18w600White,
                ),
              ),
              // Custom input section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter custom quantity:",
                        style: AppTextStyles.text14w600White,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: customQuantityController,
                              keyboardType: TextInputType.number,
                              style: AppTextStyles.text16w500White,
                              decoration: InputDecoration(
                                hintText: "Enter number",
                                hintStyle:
                                    AppTextStyles.text16w300White.copyWith(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: Colors.white.withValues(alpha: 0.1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              final customValue =
                                  customQuantityController.text.trim();
                              if (customValue.isNotEmpty &&
                                  int.tryParse(customValue) != null &&
                                  int.parse(customValue) > 0) {
                                cubit.updateQuantity(customValue);
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.whiteTextColors,
                              foregroundColor: AppColors.blackTextColors,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Text("Set",
                                style: AppTextStyles.text14w600White.copyWith(
                                  color: AppColors.blackTextColors,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white24)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR",
                        style: AppTextStyles.text14w600White.copyWith(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white24)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Choose from preset values:",
                style: AppTextStyles.text14w600White.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 12),
              // Preset values list
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: quantities.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: InkWell(
                        onTap: () {
                          cubit.updateQuantity(quantities[index]);
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              quantities[index],
                              style: AppTextStyles.text16w500Black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // This widget is used statically
  }
}
