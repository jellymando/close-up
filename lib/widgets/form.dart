import 'package:flutter/material.dart';

import 'package:close_up/widgets/button.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> children;
  final void Function()? onSubmit;
  final String? submitText;
  const FormContainer(
      {Key? key, required this.children, this.submitText, this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (submitText != null && onSubmit != null)
              ? [
                  ...children,
                  SizedBox(height: 30.0),
                  Container(
                    width: double.infinity,
                    height: 44.0,
                    child: Button(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onSubmit!();
                        }
                      },
                      child: Text(submitText!),
                    ),
                  )
                ]
              : children),
    );
  }
}
