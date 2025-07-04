import 'package:flutter/material.dart';

import 'responsive.dart';

class Search extends StatelessWidget {
  final String buttonText;
  final Function()? buttonOnPressed;

  final bool hideSearch;
  final Function(String)? onSearch;
  final bool hideButton;

  const Search(this.buttonText, this.buttonOnPressed,
      {this.hideSearch = false,
      this.hideButton = false,
      this.onSearch,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(children: [
        if (Responsive.isDesktop(context))
          SizedBox(
            width: 300,
            child: TextField(
                decoration: const InputDecoration(
                  labelText: "Pretraga",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: onSearch),
          ),
        if (Responsive.isDesktop(context))
          Expanded(
            child: Container(),
          ),
        if (!hideButton)
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            style: Responsive.isMobile(context)
                ? ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.only(
                        left: 15, top: 15, right: 15, bottom: 15)),
                  )
                : ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 20)),
                  ),
            label: Text(buttonText),
            onPressed: buttonOnPressed,
          ),
      ]),
    );
  }
}
