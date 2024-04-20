import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/auth_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_text_field.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_button.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_string_helper.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final FocusNode _userNameFocus = FocusNode();

  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  final TextEditingController _passWordController = TextEditingController();
  final FocusNode _passWordFocus = FocusNode();

  bool _isUserNameError = false;
  bool _isEmailError = false;
  bool _isPasswordError = false;

  int  numberMaxLength = 11;
  String text = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (auth) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(MySizes.paddingSizeDefault),
              child: SingleChildScrollView(
                child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Container(
                          height: 220,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                          margin: const EdgeInsets.fromLTRB(0,0,8,0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: MyColor.getSurfaceColor(),
                            boxShadow: [BoxShadow(
                                color: MyColor.getGreyColor().withOpacity(0.2),
                                blurRadius: 0.1,
                                spreadRadius: 0.2,
                                offset: const Offset(0,1)
                            )],
                          ),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('NUB Book', style: robotoBold.copyWith(fontSize: 36,color:  MyColor.getPrimaryColor())),
                              const SizedBox(height: MySizes.paddingSizeExtraSmall),
                              Text('Make life easy and keep notes of everything', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge), textAlign: TextAlign.center,),
                            ],
                          )
                      ),
                    ),

                    const SizedBox(height: MySizes.paddingSizeMiniSmall),

                    CustomTextField(
                      controller: _userNameController,
                      focusNode: _userNameFocus,
                      nextFocus: _emailFocus,
                      hintText: 'Username',
                      fillColor: MyColor.colorWhite,
                      backgroundColor: MyColor.colorWhite,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      borderRadius: BorderRadius.circular(50),
                      onChanged: (text){
                        setState(() {
                          _isUserNameError = false;
                        });
                      },
                    ),

                    /// for error msg
                    if(_isUserNameError)...[
                      const SizedBox(height: 6),
                      Text('Please enter username',style: robotoRegular.copyWith(color: Colors.red,fontSize: MySizes.fontSizeExtraSmall)),
                    ],

                    const SizedBox(height: MySizes.paddingSizeMiniSmall),

                     CustomTextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _phoneFocus,
                      hintText: 'Email',
                      fillColor: MyColor.colorWhite,
                      backgroundColor: MyColor.colorWhite,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      borderRadius: BorderRadius.circular(50),
                       onChanged: (text){
                         setState(() {
                           _isEmailError = false;
                         });
                       },
                    ),

                    /// for error msg
                    if(_isEmailError)...[
                      const SizedBox(height: 6),
                      Text('Please enter email',style: robotoRegular.copyWith(color:  Colors.red,fontSize: MySizes.fontSizeExtraSmall)),
                    ],
                    const SizedBox(height: MySizes.paddingSizeMiniSmall),


                  /*  /// for phone number
                    CustomTextField(
                      controller: _phoneController,
                      focusNode: _phoneFocus,
                      nextFocus: _passWordFocus,
                      hintText: 'Phone',
                      fillColor: MyColor.colorWhite,
                      backgroundColor: MyColor.colorWhite,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      borderRadius: BorderRadius.circular(50),
                       onChanged: (newVal){
                        setState(() {
                          _isNumberError = false;
                          if(newVal.length <= numberMaxLength){
                            text = newVal;
                          }else{
                            _phoneController.value = TextEditingValue(
                                text: text,
                                selection: TextSelection(
                                    baseOffset: numberMaxLength,
                                    extentOffset: numberMaxLength,
                                    affinity: TextAffinity.downstream,
                                    isDirectional: false
                                ),
                                composing: TextRange(
                                    start: 0, end: numberMaxLength
                                )
                            );
                            _phoneController.text = text;
                          }
                        });
                      },
                    ),

                    /// for error msg
                    if(_isNumberError)...[
                      const SizedBox(height: 6),
                      Text('Please enter number',style: robotoRegular.copyWith(color:  Colors.red,fontSize: MySizes.fontSizeExtraSmall)),
                    ],
                    const SizedBox(height: MySizes.paddingSizeMiniSmall),
*/

                    CustomTextField(
                      controller: _passWordController,
                      focusNode: _passWordFocus,
                      hintText: 'Password',
                      fillColor: MyColor.colorWhite,
                      backgroundColor: MyColor.colorWhite,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.text,
                      borderRadius: BorderRadius.circular(50),
                      onChanged: (text){
                        setState(() {
                          _isPasswordError = false;
                        });
                      },
                    ),

                    /// for error msg
                    if(_isPasswordError)...[
                      const SizedBox(height: 6),
                      Text('Please enter password',style: robotoRegular.copyWith(color:  Colors.red,fontSize: MySizes.fontSizeExtraSmall)),
                    ],

                    const SizedBox(height: MySizes.paddingSizeMiniSmall),


                    const SizedBox(height: MySizes.paddingSizeMiniSmall),
                    CustomButton(text: 'SignUp', onTap: (){
                      final userName = _userNameController.text;
                      final email = _emailController.text;
                      final phone = _phoneController.text;
                      final password = _passWordController.text;
                      if(userName.isEmpty){
                        setState(() {
                          _isUserNameError = true;
                        });
                      }else if (!validateEmail(email)) {
                        setState(() {
                          _isEmailError = true;
                        });
                      }
                      /*else if(phone.isEmpty){
                        setState(() {
                          _isNumberError = true;
                        });
                      }*/
                      else if(password.isEmpty){
                        setState(() {
                          _isPasswordError = true;
                        });
                      }else{
                        auth.registration(userName,email, password, phone);
                      }
                    }),

                    const SizedBox(height: MySizes.paddingSizeExtraLarge),
                    RichText(text: TextSpan(
                        text: "Already have an account?",
                        style: robotoRegular.copyWith(
                            fontSize: MySizes.fontSizeDefault,
                            color: MyColor.getGreyColor()),
                        children: [
                          const TextSpan(text: ' '),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = Get.back,
                            text: 'Go back',
                            style: robotoRegular.copyWith(
                                fontSize: MySizes.fontSizeLarge,
                                color: MyColor.getPrimaryColor()),
                          )
                        ]
                    )),

                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
