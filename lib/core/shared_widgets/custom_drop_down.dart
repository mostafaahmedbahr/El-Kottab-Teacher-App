
import '../../main_imports.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String hint;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final String Function(T) itemDisplayBuilder;
  final Color backgroundColor;
  final Color borderColor;
  final Color hintColor;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
    required this.itemDisplayBuilder,
    this.height = 56.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.grayLight,
    this.hintColor = const Color.fromRGBO(150, 150, 150, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: DropdownButton<T>(
        padding: padding,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        value: value,
        hint: Text(
          hint,
          style: TextStyle(color: hintColor),
        ),
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 14,
        ),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(itemDisplayBuilder(item)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}