library delayed_autocomplete;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeyaledAutocomplete extends StatefulWidget {
  final Future<List> Function(String suggestion) toDo;
  final Widget Function(dynamic object) itemWidget;
  final int delayinMilliseconds;
  final Color borderColor;
  final String hintText;
  const DeyaledAutocomplete(
      {super.key,
      required this.toDo,
      required this.itemWidget,
      this.borderColor = Colors.blue,
      this.delayinMilliseconds = 500,
      this.hintText = 'Search'});

  @override
  State<DeyaledAutocomplete> createState() => _DeyaledAutocompleteState();
}

class _DeyaledAutocompleteState extends State<DeyaledAutocomplete> {
  Timer? _debounce;
  List suggestions = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: widget.borderColor,
      ),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: widget.borderColor, width: 3.0),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: inputBorder,
                  focusedBorder: inputFocusBorder,
                  prefixIcon: Icon(
                    Icons.search,
                  )),
              onChanged: (String value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                isLoading = true;
                setState(() {});
                _debounce = Timer(const Duration(milliseconds: 2000), () async {
                  widget.toDo(_searchController.text).then((value) {
                    suggestions = value;
                    isLoading = false;
                    setState(() {});
                  });
                });
              }),
          SizedBox(
            height: 10,
          ),
          isLoading == false
              ? StatefulBuilder(builder: ((context, setState) {
                  return ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return widget.itemWidget(suggestions[index]);
                      });
                }))
              : Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}
