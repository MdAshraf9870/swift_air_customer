import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AppConst/AppConst.dart';

class TextBoxs {

  static Widget AppTextFormField(TextEditingController controller,
      {double? borderWidth=1,List<TextInputFormatter>? inputFormatters,TextInputType? keyboardType
      ,double borderRadius=8,String? label,double? size,int maxLine=1,
        FocusNode? focusNode,String errorMsg="",Function? onChange,
        bool obscureText=false,Widget? prefixIcon,Widget? suffixIcon
      }){
    print(errorMsg);
    return SizedBox(
      height: size,
      child: TextFormField(
        onChanged: (v)=>onChange!(v),
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLine,
        obscureText: obscureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
         suffixIcon: suffixIcon,
         // errorText: errorMsg.isEmpty? null:errorMsg,
         // errorMaxLines: 5,
          label: label !=null ?errorMsg.isEmpty?Text(label):Text(errorMsg):null,
          labelStyle:  TextStyle(fontSize: 16, color: errorMsg.isEmpty?  Color(0xfff6d7ab5):Colors.red),
          //contentPadding: EdgeInsets.symmetric(horizontal: 4),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color:errorMsg.isEmpty? Color(0xfff6d7ab5):Colors.red,
                width: borderWidth!,
              ),
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:errorMsg.isEmpty? Color(0xfff6d7ab5):Colors.red,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color:errorMsg.isEmpty?  Color(0xfff6d7ab5):Colors.red,
                  width: borderWidth
              )
          ),
        ),
      ),
    );
  }

}