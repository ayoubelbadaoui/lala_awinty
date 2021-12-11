import 'package:flutter/material.dart';
import 'package:lala_awinty/constants/colors.dart';

class AppSelectorOption extends StatefulWidget {
  const AppSelectorOption({Key? key}) : super(key: key);

  @override
  State<AppSelectorOption> createState() => _AppSelectorOptionState();
}

class _AppSelectorOptionState extends State<AppSelectorOption> {
  String dropdownValue = '30-50';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.attach_money_rounded),
      elevation: 16,
      isExpanded: true,
      style: TextStyle(color: primaryColor),
      underline: Container(
        height: 2,
        color: primaryColor,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['30-50', '50-70']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
