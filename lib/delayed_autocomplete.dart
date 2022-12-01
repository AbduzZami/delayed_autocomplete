library delayed_autocomplete;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeyaledAutocomplete extends StatefulWidget {
  final List Function(String suggestion) toDo;
  final Widget Function(dynamic object) itemWidget;
  final int delayinMilliseconds;
  final Color borderColor;
  const DeyaledAutocomplete(
      {super.key,
      required this.toDo,
      required this.itemWidget,
      this.borderColor = Colors.blue,
      this.delayinMilliseconds = 500});

  @override
  State<DeyaledAutocomplete> createState() => _DeyaledAutocompleteState();
}

class _DeyaledAutocompleteState extends State<DeyaledAutocomplete> {
  Timer? _debounce;
  List suggestions = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.borderColor),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.borderColor, width: 3.0),
    );
    return Column(
      children: [
        TextFormField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Search Location',
              border: inputBorder,
              focusedBorder: inputFocusBorder,
            ),
            onChanged: (String value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();

              _debounce = Timer(const Duration(milliseconds: 2000), () async {
                suggestions = widget.toDo(_searchController.text);
                setState(() {});
              });
            }),
        StatefulBuilder(builder: ((context, setState) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: suggestions.length > 5 ? 5 : suggestions.length,
              itemBuilder: (context, index) {
                return widget.itemWidget(suggestions[index]);
              });
        })),
      ],
    );
  }
}
