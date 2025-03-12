import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CustomMultiDropdown<T extends Object> extends StatelessWidget {
  final String hintText;
  final List<DropdownItem<T>> items;
  final OnSelectionChanged<T>? onSelectionChange;
  final String? Function(List<DropdownItem<T>>?)? validator;
  final bool enabled;
  final bool searchEnabled;
  final Color chipBackgroundColor;
  final Color selectedBackgroundColor;
  final Color selectedTextColor;
  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final bool showClearIcon;
  final double dropdownMaxHeight;
  final String dropdownHeaderText;

  const CustomMultiDropdown({
    super.key,
    required this.items,
    this.hintText = 'Select Items',
    this.onSelectionChange,
    this.validator,
    this.enabled = true,
    this.searchEnabled = true,
    this.chipBackgroundColor = Colors.white,
    this.selectedBackgroundColor = Colors.blue,
    this.selectedTextColor = Colors.white,
    this.borderRadius = 12,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.black87,
    this.showClearIcon = false,
    this.dropdownMaxHeight = 500,
    this.dropdownHeaderText = 'Select Items',
  });

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<T>(
      items: items,
      enabled: enabled,
      searchEnabled: searchEnabled,
      chipDecoration: ChipDecoration(
        backgroundColor: chipBackgroundColor,
        wrap: true,
        runSpacing: 2,
        spacing: 10,
        border: Border.all(color: selectedBackgroundColor),
      ),
      fieldDecoration: FieldDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black87),
        showClearIcon: showClearIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: focusedBorderColor,
          ),
        ),
      ),
      dropdownDecoration: DropdownDecoration(
        marginTop: 2,
        maxHeight: dropdownMaxHeight,
        header: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            dropdownHeaderText,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      dropdownItemDecoration: DropdownItemDecoration(
        selectedBackgroundColor: selectedBackgroundColor,
        selectedTextColor: selectedTextColor,
        selectedIcon: const Icon(null, color: Colors.white),
        disabledIcon: Icon(null, color: Colors.grey.shade300),
      ),
      validator: validator,
      onSelectionChange:
          onSelectionChange, // ✅ Now matches the expected function type
    );
  }
}
