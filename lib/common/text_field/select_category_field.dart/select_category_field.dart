import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class SelectCategoryField extends StatefulWidget {
  final TextEditingController controller;
  final Color fillcolor;
  final String hintText;
  final TextStyle hintStyle;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final List<String>? dropdownItems;

  const SelectCategoryField({
    super.key,
    required this.hintStyle,
    required this.fillcolor,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines,
    this.dropdownItems,
  });

  @override
  State<SelectCategoryField> createState() => _SelectCategoryFieldState();
}

class _SelectCategoryFieldState extends State<SelectCategoryField> {
  final GlobalKey _iconKey = GlobalKey();

  Future<void> _showDropdownMenu(BuildContext context) async {
    final RenderBox renderBox =
        _iconKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + size.height,
        position.dx + size.width,
        position.dy,
      ),
      items: widget.dropdownItems!
          .map((item) => PopupMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );

    if (selected != null) {
      setState(() {
        widget.controller.text = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines ?? 1,
      style: const TextStyle(color: Colors.white),
      validator: widget.validator,
      readOnly: widget.dropdownItems != null,
      onTap: widget.dropdownItems != null
          ? () => _showDropdownMenu(context)
          : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        filled: true,
        fillColor: widget.fillcolor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Color.fromARGB(255, 11, 10, 10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color.fromARGB(255, 40, 36, 36)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 36, 32, 32),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
        suffixIcon: widget.dropdownItems != null
            ? GestureDetector(
                key: _iconKey,
                onTap: () => _showDropdownMenu(context),
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.textHint,
                ),
              )
            : null,
      ),
    );
  }
}
