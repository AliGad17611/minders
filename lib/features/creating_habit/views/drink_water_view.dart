import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/manger/cubit/crating_habit_cubit.dart';
import 'package:minders/features/creating_habit/manger/cubit/creating_habit_states.dart';
import 'package:minders/features/creating_habit/manger/models/habit_model.dart';
import 'package:minders/features/creating_habit/views/choice_habit_view.dart';
import 'package:minders/features/common/top_space.dart';
import 'package:minders/features/creating_habit/views/widgets/frequency_selection_buttons.dart';
import 'package:minders/features/creating_habit/views/widgets/habit_continue_button.dart';
import 'package:minders/features/creating_habit/views/widgets/quantity_picker_modal.dart';
import 'package:minders/features/creating_habit/views/widgets/quantity_unit_selector.dart';
import 'package:minders/features/creating_habit/views/widgets/unit_picker_modal.dart';
import 'package:minders/features/creating_habit/views/widgets/week_days_list_view.dart';

class DrinkWaterView extends StatefulWidget {
  const DrinkWaterView({super.key, required this.habit});
  final HabitModel habit;

  @override
  State<DrinkWaterView> createState() => _DrinkWaterViewState();
}

class _DrinkWaterViewState extends State<DrinkWaterView> {
  String selectedQuantity = "5";
  String selectedUnit = "Glasses";
  String selectedFrequency = "Daily";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatingHabitCubit(),
      child: BlocConsumer<CreatingHabitCubit, CreatingHabitStates>(
        listener: (context, state) {
          if (state is CreatingHabitSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChoiceHabitView(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(AppFrames.water),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TopSpace(height: 90),
                        Text("SET YOUR GOALS",
                            style: AppTextStyles.text30w600White),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Set your goals", style: AppTextStyles.text14w600White),
                SizedBox(height: 20),
                BlocBuilder<CreatingHabitCubit, CreatingHabitStates>(
                  builder: (context, state) {
                    String currentQuantity = selectedQuantity;
                    String currentUnit = selectedUnit;

                    // Update from cubit state if available
                    if (state is CreatingHabitDetailsSelectedState) {
                      currentQuantity = state.goalAmount;
                      currentUnit = state.goalUnit;

                      // Update local state to stay in sync
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            selectedQuantity = state.goalAmount;
                            selectedUnit = state.goalUnit;
                          });
                        }
                      });
                    }

                    return QuantityUnitSelector(
                      quantityText: currentQuantity,
                      unitText: currentUnit,
                      onQuantityPressed: () => QuantityPickerModal.show(
                          context, context.read<CreatingHabitCubit>()),
                      onUnitPressed: () => UnitPickerModal.show(
                          context, context.read<CreatingHabitCubit>()),
                    );
                  },
                ),
                SizedBox(height: 20),
                FrequencySelectionButtons(
                  selectedFrequency: selectedFrequency,
                  onFrequencyChanged: (frequency) {
                    setState(() {
                      selectedFrequency = frequency;
                    });
                  },
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Repeat everyday",
                        style: AppTextStyles.text18w600White),
                  ),
                ),
                SizedBox(height: 30),
                WeekDaysListView(
                  frequency: selectedFrequency,
                ),
                SizedBox(height: 30),
                HabitContinueButton(
                  selectedQuantity: selectedQuantity,
                  selectedUnit: selectedUnit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
