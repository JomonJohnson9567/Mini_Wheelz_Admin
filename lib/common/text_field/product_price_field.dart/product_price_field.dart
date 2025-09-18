import 'package:flutter/material.dart';

class ProductPriceField extends StatefulWidget {
  final TextEditingController controller;
  final Color fillcolor;
  final int? width;
  final String hintText;
  final TextStyle hintStyle;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  const ProductPriceField({
    super.key,
    required this.hintStyle,
    required this.fillcolor,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.width,
    this.maxLines,
    this.onChanged,
  });

  @override
  State<ProductPriceField> createState() => _ProductPriceFieldState();
}

class _ProductPriceFieldState extends State<ProductPriceField> {
  bool _obscureText = true;

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width?.toDouble(),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.keyboardType,
        // Fix: If isPassword is true, force maxLines to 1
        maxLines: widget.isPassword ? 1 : (widget.maxLines ?? 1),
        style: const TextStyle(color: Color.fromARGB(255, 22, 17, 17)),
        validator: widget.validator,
        onChanged: widget.onChanged,

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
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 11, 10, 10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 40, 36, 36),
            ),
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
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: const Color.fromARGB(179, 255, 254, 254),
                  ),
                  onPressed: _toggleObscure,
                )
              : null,
        ),
      ),
    );
  }
}
