import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Function validator;
  final Function onFieldSubmitted;
  final TextInputAction textInputAction;

  const PasswordFormField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
  })  : assert(controller != null),
        assert(labelText != null),
        assert(validator != null),
        super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      autovalidate: true,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      obscureText: !_showPassword,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
    );
  }
}
