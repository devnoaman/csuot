import 'package:csuot/data/constants.dart';
import 'package:flutter/material.dart';

class MyFormFeild extends StatelessWidget {
  final String title;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final String? hint;
  final TextEditingController? controller;
  final Function(dynamic text)? onChange;

  const MyFormFeild({
    Key? key,
    required this.title,
    this.maxLines,
    this.keyBoardType = TextInputType.text,
    this.validator,
    this.hint,
    this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: getWidth(context),
        // height: getHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              validator: validator,
              onChanged: onChange,

              maxLines: maxLines,
              keyboardType: keyBoardType,
              controller: controller,

              // },
              decoration: InputDecoration(
                filled: true,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                // fillColor: Colors.grey[300],

                // prefixIcon: Icon(Icons.perm_identity),
                hintStyle: TextStyle(color: Colors.black),
                // hintText: hint,
                // labelText: 'اسم المستخدم',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
