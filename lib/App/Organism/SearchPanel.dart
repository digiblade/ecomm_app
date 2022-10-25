import 'package:ecommerce/Component2/Input/InputField.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(
            flex: 4,
            child: InputField(
              label: "search",
            ),
          ),
          Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: primary,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ))
        ],
      ),
    );
  }
}
