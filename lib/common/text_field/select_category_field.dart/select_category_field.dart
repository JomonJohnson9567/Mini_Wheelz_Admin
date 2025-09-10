import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/add_category/bloc/category_bloc.dart';

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

  Future<void> _showBottomSheet(
    BuildContext context,
    List<String> items,
  ) async {
    String query = '';
    String? selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (ctx) {
        final media = MediaQuery.of(ctx);
        return Container(
          height: media.size.height * 0.6,
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: StatefulBuilder(
            builder: (ctx, setModalState) {
              final filtered = items
                  .where((e) => e.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              return Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search categories',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Theme.of(ctx).colorScheme.surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (v) => setModalState(() => query = v),
                    ),
                  ),
                  const SizedBox(height: 8),
               
                  Expanded(
                    child: filtered.isEmpty
                        ? Center(
                            child: Text(
                              query.isEmpty
                                  ? 'No categories available'
                                  : 'No results for "$query"',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 4),
                            itemBuilder: (ctx, index) {
                              final name = filtered[index];
                              final isSelected = name == widget.controller.text;
                              return ListTile(
                                leading: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primary.withOpacity(0.85),
                                        AppColors.primary,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.category,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  name,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                                trailing: isSelected
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    : const Icon(Icons.chevron_right),
                                onTap: () => Navigator.of(ctx).pop(name),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        widget.controller.text = selected;
      });
      // Ensure the field loses focus so the sheet closes cleanly
      FocusScope.of(context).unfocus();
    }
  }

  void _openPicker(BuildContext context) {
    // Prefer provided items; otherwise use CategoryBloc state
    final provided = widget.dropdownItems;
    if (provided != null) {
      _showBottomSheet(context, provided);
      return;
    }
    final blocState = context.read<CategoryBloc>().state;
    _showBottomSheet(context, blocState.categories.map((e) => e.name).toList());
  }

  @override
  Widget build(BuildContext context) {
    final usesBloc = widget.dropdownItems == null;
    final hasSelection = widget.controller.text.trim().isNotEmpty;
    final field = TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines ?? 1,
      style: const TextStyle(color: Colors.black),
      validator: widget.validator,
      readOnly: true,
      onTap: () => _openPicker(context),
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
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasSelection)
              IconButton(
                tooltip: 'Clear',
                icon: const Icon(Icons.close, color: AppColors.textHint),
                onPressed: () {
                  setState(() {
                    widget.controller.clear();
                  });
                },
              ),
            GestureDetector(
              key: _iconKey,
              onTap: () => _openPicker(context),
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_drop_down, color: AppColors.textHint),
              ),
            ),
          ],
        ),
      ),
    );

    if (!usesBloc) return field;

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.status == CategoryStatus.loading &&
            state.categories.isEmpty) {
          return AbsorbPointer(child: Opacity(opacity: 0.7, child: field));
        }
        return field;
      },
    );
  }
}
