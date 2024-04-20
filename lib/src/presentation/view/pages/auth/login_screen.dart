import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/auth_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_text_field.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_button.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/auth/registation_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final FocusNode _userNameFocus = FocusNode();

  final TextEditingController _passWordController = TextEditingController();
  final FocusNode _passWordFocus = FocusNode();

  int nameMaxLength = 11;
  String text = "";

  bool _isEmailError = false;
  bool _isPasswordError = false;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (auth)=> Scaffold(
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
                      nextFocus: _passWordFocus,
                      hintText: 'Email',
                      fillColor: MyColor.colorWhite,
                      backgroundColor: MyColor.colorWhite,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    /// for error msg
                    if(_isEmailError)...[
                      const SizedBox(height: 6),
                      Text('Please enter email',style: robotoRegular.copyWith(color:  Colors.red,fontSize: MySizes.fontSizeExtraSmall)),
                    ],

                    const SizedBox(height: MySizes.paddingSizeMiniSmall),

                    CustomTextField(
                      controller: _passWordController,
                      focusNode: _passWordFocus,
                      hintText: 'Password',
                      fillColor: MyColor.colorWhite,
                      backgroundColor: MyColor.colorWhite,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.text,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    /// for error msg
                    if(_isPasswordError)...[
                      const SizedBox(height: 6),
                      Text('Please enter password',style: robotoRegular.copyWith(color:  Colors.red,fontSize: MySizes.fontSizeExtraSmall)),
                    ],

                    const SizedBox(height: MySizes.paddingSizeMiniSmall),



                    const SizedBox(height: MySizes.paddingSizeMiniSmall),
                    CustomButton(text: 'LogIn', onTap: (){
                      final email = _userNameController.text;
                      final password = _passWordController.text;
                     if (email.isEmpty) {
                        setState(() {
                          _isEmailError = true;
                        });
                      }else if(password.isEmpty){
                        setState(() {
                          _isPasswordError = true;
                        });
                      }else{
                        auth.login(email, password);
                      }
                    }),

                    const SizedBox(height: MySizes.paddingSizeExtraLarge),
                    RichText(text: TextSpan(
                      text: "Don't have an account?",
                      style: robotoRegular.copyWith(
                          fontSize: MySizes.fontSizeDefault,
                          color: MyColor.getGreyColor()),
                      children: [
                        const TextSpan(text: ' '),

                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(context, CupertinoPageRoute(builder: (_) => const RegistrationScreen())),
                          text: 'SignUp',
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
