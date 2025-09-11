import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.controller,
    required this.label,
    this.isRequired = false,
    this.fillColor = AppColors.backgroundSecondary,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.errorText,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.hintText,
    this.focusNode,
    this.selectAllOnTap = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final bool isRequired;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? errorText;
  final int? minLines;
  final int? maxLines;
  final bool obscureText;
  final String? hintText;
  final FocusNode? focusNode;
  final bool selectAllOnTap;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validator,
      style: AppTextStyles.text16w300Black,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textAlign: TextAlign.left,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: () {
        if (widget.selectAllOnTap) {
          widget.controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: widget.controller.text.length,
          );
        }
        widget.onTap?.call();
      },
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      minLines: widget.obscureText ? 1 : widget.minLines ?? 1,
      maxLines: widget.obscureText ? 1 : widget.maxLines ?? 5,
      selectionHeightStyle: BoxHeightStyle.max,
      obscureText: obscureText,
      decoration: _buildInputDecoration(context),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return _inputDecoration(
      context: context,
      label: _label(context),
      errorText: widget.errorText,
      suffixIcon: widget.suffixIcon ?? _obscureIcon(),
      fillColor: widget.fillColor,
      hintText: widget.hintText,
    );
  }

  IconButton? _obscureIcon() {
    return widget.obscureText
        ? IconButton(
            onPressed: () => setState(() => obscureText = !obscureText),
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          )
        : null;
  }

  String? _validator(value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return 'Please enter ${widget.label}';
    }
    if (value != null && value.isNotEmpty && widget.keyboardType != null) {
      if (widget.keyboardType == TextInputType.number) {
        // widget.controller.text = value.toString().trim();
        try {
          double.parse(value);
        } catch (e) {
          return 'Please enter a valid number';
        }
      }
      if (widget.keyboardType == TextInputType.phone) {
        // widget.controller.text = value.toString().trim();
        try {
          int.parse(value);
          if (!value.startsWith("01")) {
            return 'Please enter a valid number';
          }
          if (value.length != 11) {
            return 'Please enter 11 digits';
          }
        } catch (e) {
          return 'Please enter a valid number';
        }
      }
    }
    return widget.validator?.call(value);
  }

  Row _label(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.prefixIcon != null)
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: widget.prefixIcon,
          ),
        Text.rich(
          TextSpan(
            text: widget.label,
            style: AppTextStyles.text16w300Black.copyWith(
              color: AppColors.tertiaryTextColors,
            ),
            children: [
              if (widget.isRequired)
                TextSpan(
                  text: ' *',
                  style: AppTextStyles.text16w300Black.copyWith(
                    color: AppColors.purpleMain,
                  ),
                ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

InputDecoration _inputDecoration({
  required BuildContext context,
  required Widget label,
  String? errorText,
  Widget? suffixIcon,
  Color? fillColor,
  String? hintText,
}) {
  return InputDecoration(
    label: label,
    hintText: hintText,
    hintStyle: AppTextStyles.text16w300Black.copyWith(
      color: AppColors.tertiaryTextColors,
    ),
    suffixIcon: suffixIcon,
    suffixIconColor: AppColors.tertiaryTextColors,
    filled: true,
    fillColor: fillColor,
    errorText: errorText,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 22.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.borderSecondary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.borderSecondary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.purpleMain),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.purpleMain),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.errorTextColors),
    ),
  );
}
