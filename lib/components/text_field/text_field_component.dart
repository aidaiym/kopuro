import 'package:flutter/material.dart';

import '../../constants/contants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.description,
    required this.obscureText, this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final String validator;
  final String description;
  final bool obscureText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: AppTextStyles.black14,
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return validator;
              }
              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: label,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.main,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
