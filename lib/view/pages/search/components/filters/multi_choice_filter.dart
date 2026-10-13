import 'package:flutter/material.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_choice_chip.dart';

class MultiChoiceFilter<T> extends StatelessWidget {
  const MultiChoiceFilter({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.labelBuilder,
    required this.onChanged,
  });

  final List<T> options;
  final List<T> selectedOptions;
  final String Function(T) labelBuilder;
  final void Function(List<T>) onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final T option in options)
          FilterChoiceChip(
            label: labelBuilder(option),
            isSelected: selectedOptions.contains(option),
            onTap: () => _onOptionTapped(option),
          ),
      ],
    );
  }

  void _onOptionTapped(T option) {
    final Set<T> selected = {...selectedOptions};
    if (!selected.remove(option)) selected.add(option);
    onChanged(options.where(selected.contains).toList());
  }
}
