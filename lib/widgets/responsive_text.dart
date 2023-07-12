import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/responsive_calculations.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  /// just a quick access. will be ignored if textStyle is provided
  final Color? color;

  /// just a quick access. will be ignored if textStyle is provided
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final double fontSize;
  final TextStyle? textStyle;
  final MaterialState? materialState;
  final bool? softWrap;

  const ResponsiveText(
    this.text, {
    Key? key,
    this.fontSize = 14,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.textStyle,
    this.materialState,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle != null
          ? textStyle!.copyWith(
              fontSize: ResponsivityHelper.responsiveFontSize(fontSize),
            )
          : TextStyle(
              fontSize: ResponsivityHelper.responsiveFontSize(fontSize),
              color: color,
              fontWeight: fontWeight,
            ),

      // calculateTextStyle(
      //     context,
      //     textType: textType,
      //     materialState: materialState,
      //   )?.copyWith(
      //     fontSize: ResponsivityHelper.responsiveFontSize(fontSize),
      //     color: color,
      //     fontWeight: fontWeight,
      //   ),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}

class ResponsiveInput extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isDense;
  final bool enabled;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? labelStyle;
  final TextInputType keyboardType;
  final AutovalidateMode? autoValidateMode;
  final List<TextInputFormatter>? inputFormatter;
  final int maxLength;
  final double fontSize;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final IconData? suffixIconData;
  final IconData? prefixIconData;
  final Color? iconColor;
  final Color? prefixIconColor;
  final void Function()? onIconPressed;
  final void Function()? onTap;

  const ResponsiveInput({
    Key? key,
    this.labelText,
    this.hintText,
    this.fontSize = 14,
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.autoValidateMode,
    this.textStyle,
    this.hintStyle,
    this.errorStyle,
    this.labelStyle,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLength = 50,
    this.inputFormatter,
    this.onSaved,
    this.onChanged,
    this.isDense = true,
    this.suffixIconData,
    this.prefixIconData,
    this.iconColor,
    this.prefixIconColor,
    this.onIconPressed,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  _ResponsiveInputState createState() => _ResponsiveInputState();
}

class _ResponsiveInputState extends State<ResponsiveInput> {
  final _focus = FocusNode();
  final _iconFieldSize = 3;
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // for styling
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      autovalidateMode: widget.autoValidateMode,
      showCursor: true,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatter,
      focusNode: _focus,
      onTap: widget.onTap,
      obscureText: widget.obscureText,
      style: widget.textStyle != null
          ? widget.textStyle!.copyWith(
              fontSize: ResponsivityHelper.responsiveFontSize(
                  widget.textStyle!.fontSize ?? 14),
            )
          : TextStyle(
              fontSize: ResponsivityHelper.responsiveFontSize(widget.fontSize),
            ),
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        fillColor: _theme.inputDecorationTheme.fillColor,
        filled: true,
        isDense: widget.isDense,
        contentPadding: EdgeInsets.only(
          left: 2.horizontalPercent(),
          top: 2.horizontalPercent(),
          bottom: 1.verticalPercent(),
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: widget.hintStyle != null
            ? widget.hintStyle!.copyWith(
                fontSize: ResponsivityHelper.responsiveFontSize(
                    widget.hintStyle!.fontSize ?? widget.fontSize),
              )
            : TextStyle(
                fontSize:
                    ResponsivityHelper.responsiveFontSize(widget.fontSize),
              ),
        errorStyle: widget.errorStyle != null
            ? widget.errorStyle!.copyWith(
                fontSize: ResponsivityHelper.responsiveFontSize(
                    widget.errorStyle!.fontSize ?? widget.fontSize),
              )
            : TextStyle(
                fontSize:
                    ResponsivityHelper.responsiveFontSize(widget.fontSize),
              ),
        counter: const SizedBox.shrink(),
        labelStyle: widget.labelStyle != null
            ? widget.labelStyle!.copyWith(
                fontSize: ResponsivityHelper.responsiveFontSize(
                    widget.labelStyle!.fontSize ?? widget.fontSize),
              )
            : TextStyle(
                fontSize:
                    ResponsivityHelper.responsiveFontSize(widget.fontSize),
              ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        prefixIconConstraints: BoxConstraints(
          minHeight: _iconFieldSize.verticalPercent(),
          maxHeight: (_iconFieldSize * 2).verticalPercent(),
          minWidth: (_iconFieldSize + 1).verticalPercent(),
          maxWidth: (_iconFieldSize + 1).verticalPercent(),
        ),
        prefixIcon: widget.prefixIconData != null
            ? Icon(
                widget.prefixIconData,
                color: widget.prefixIconColor,
                size: _iconFieldSize.verticalPercent(),
              )
            : null,
        suffixIcon: widget.suffixIconData != null
            ? InkWell(
                onTap: () {
                  if (widget.onIconPressed != null) {
                    widget.onIconPressed!();
                  }
                },
                child: Icon(
                  widget.suffixIconData,
                  color: widget.iconColor ?? _theme.iconTheme.color,
                  size: _iconFieldSize.verticalPercent(),
                ),
              )
            : null,
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }
}

class ResponsiveFormFieldButton<T> extends StatefulWidget {
  const ResponsiveFormFieldButton({
    Key? key,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.fontSize = 26,
    this.value,
    this.icon = Icons.arrow_drop_down,
    this.onIconTap,
    this.textStyle,
    this.errorStyle,
    this.labelStyle,
    this.hintStyle,
    required this.items,
  }) : super(key: key);

  final Function(T?)? onSaved;
  final String Function(T?)? validator;
  final Function(T?)? onChanged;
  final String? labelText;
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final double fontSize;
  final T? value;
  final IconData icon;
  final Function()? onIconTap;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? labelStyle;
  @override
  _ResponsiveFormFieldButtonState<T> createState() =>
      _ResponsiveFormFieldButtonState<T>();
}

class _ResponsiveFormFieldButtonState<T>
    extends State<ResponsiveFormFieldButton<T>> {
  final _iconFieldSize = 3;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.hintText,
        isDense: true,
        contentPadding: EdgeInsets.only(
          left: ResponsivityHelper.horizontalUnit / 2,
          bottom: ResponsivityHelper.verticalUnit,
        ),
        hintStyle: widget.hintStyle != null
            ? widget.hintStyle!.copyWith(
                fontSize: ResponsivityHelper.responsiveFontSize(
                    widget.hintStyle!.fontSize ?? widget.fontSize),
              )
            : TextStyle(
                fontSize:
                    ResponsivityHelper.responsiveFontSize(widget.fontSize),
              ),
        errorStyle: widget.errorStyle != null
            ? widget.errorStyle!.copyWith(
                fontSize: ResponsivityHelper.responsiveFontSize(
                    widget.errorStyle!.fontSize ?? widget.fontSize),
              )
            : TextStyle(
                fontSize:
                    ResponsivityHelper.responsiveFontSize(widget.fontSize),
              ),
        labelStyle: widget.labelStyle != null
            ? widget.labelStyle!.copyWith(
                fontSize: ResponsivityHelper.responsiveFontSize(
                    widget.labelStyle!.fontSize ?? widget.fontSize),
              )
            : TextStyle(
                fontSize:
                    ResponsivityHelper.responsiveFontSize(widget.fontSize),
              ),
      ),
      icon: Padding(
        padding: EdgeInsets.only(right: 0.25.horizontalPercent()),
        child: InkWell(
          onTap: widget.onIconTap,
          child: Icon(
            widget.icon,
            size: _iconFieldSize.verticalPercent(),
          ),
        ),
      ),
      isDense: true,
      value: widget.value,
      items: widget.items,
      onChanged: (T? newValue) {
        setState(() {
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        });
      },
      validator: (T? newValue) {
        if (widget.validator != null) {
          return widget.validator!(newValue);
        }
        return null;
      },
      onSaved: (T? newValue) {
        setState(() {
          if (widget.onSaved != null) {
            widget.onSaved!(newValue);
          }
        });
      },
      isExpanded: true,
      elevation: 2,
      style: const TextStyle(color: Colors.black),
    );
  }
}
