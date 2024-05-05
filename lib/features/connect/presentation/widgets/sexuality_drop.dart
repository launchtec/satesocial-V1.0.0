import 'package:flutter/material.dart';
import 'package:sate_social/core/util/app_constants.dart';

import '../../../../core/util/dimensions.dart';

class SexualityDrop extends StatelessWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  const SexualityDrop({super.key, required this.onChanged, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: (BuildContext context,
          TextEditingController controller,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return SizedBox(height: 30, child: TextFormField(
          style: TextStyle(
              fontSize: Dimensions.fontSizeDefault),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeSmall,
                horizontal: Dimensions.paddingSizeSmall),
            hintText: 'Type In',
            hintStyle: TextStyle(
                fontSize: Dimensions.fontSizeDefault),
            border: InputBorder.none,
          ),
          controller: controller,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        ));
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return AppConstants.sexualityList;
        }
        return AppConstants.sexualityList.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: onChanged,
      initialValue: initialValue != null ? TextEditingValue(text: initialValue!) : null,
    );
  }
}
