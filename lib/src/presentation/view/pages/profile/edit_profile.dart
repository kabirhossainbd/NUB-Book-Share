import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nub_book_sharing/main.dart';
import 'package:nub_book_sharing/model/response/chatuser_model.dart';
import 'package:nub_book_sharing/services/apis.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_button.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_string_helper.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';



//profile screen -- to show signed in user info
class EditProfileScreen extends StatefulWidget {
  final ChatUser user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
          appBar: const CustomAppBar(title: 'My profile', isShowIcon: true),
          body: Form(
            key: _formKey,
            child: ListView(
              children: [

                Container(
                  margin: const EdgeInsets.fromLTRB(16,20,16,0),
                  child: Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          if(_image != null)...[
                            ClipOval(
                              child: Image.file(
                                File(_image!),
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            )
                          ]else...[
                            ClipOval(
                              child: CachedNetworkImage(
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.profile ?? "",
                                errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
                              ),
                            ),
                          ],
                          Positioned(
                            bottom: 4,
                            right: -8,
                            child: GestureDetector(
                              onTap:  _showBottomSheet,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                    color: MyColor.getBackgroundColor(),
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey[400]!, spreadRadius: 0.1, blurRadius: 0.5, offset: const Offset(0,1)),
                                      BoxShadow(color: Colors.grey[500]!, spreadRadius: 0.1, blurRadius: 0.5, offset: const Offset(0,0))
                                    ]
                                ),
                                child: SvgPicture.asset(MyImage.upload),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( widget.user.name ?? 'Unknown', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeOverLarge), maxLines: 1,),
                          const SizedBox(height: 2),
                          Text(widget.user.email ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall),),
                        ],
                      )),
                      const SizedBox(width: 8),
                      // GestureDetector(
                      //     onTap: ()=> Navigator.push(context, PageTransition(child: ProfileScreen(user: APIs.me), type: PageTransitionType.rightToLeft)),
                      //     child: SvgPicture.asset(MyImage.edit, height: 24,width: 24,))
                      //
                    ],
                  ),
                ),

                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Overview', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                ),
                const SizedBox(height: 10),


                /// for name enter
                Container(
                  margin: const EdgeInsets.fromLTRB(16,4,16,16),
                  child: TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
                    style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Enter name',
                      hintStyle: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),
                      label:  Text('Name', style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge),),
                    ),
                  ),
                ),



                /// for email enter
                Container(
                  margin: const EdgeInsets.fromLTRB(16,4,16,16),
                  child: TextFormField(
                    readOnly: true,
                    initialValue: widget.user.email,
                    onSaved: (val) => APIs.me.email = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
                    style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Enter e-mai',
                      hintStyle: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),
                      label: Text('E-mai',style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge),),
                    ),
                  ),
                ),



                /// for phone number enter
                Container(
                  margin: const EdgeInsets.fromLTRB(16,4,16,16),
                  child:  TextFormField(
                    initialValue: widget.user.phone != 'null' ? widget.user.phone : '',
                    onSaved: (val) => APIs.me.phone = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
                    style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),
                   keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Phone',
                      hintStyle: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),
                      label: Text('Phone',style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge)),
                    ),
                  ),
                ),


                /// for varsityId
                Container(
                  margin: const EdgeInsets.fromLTRB(16,4,16,16),
                  child:  TextFormField(
                    initialValue: widget.user.varsityId,
                    onSaved: (val) => APIs.me.varsityId = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
                    style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Student ID',
                      hintStyle: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),
                      label: Text('Student ID',style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge)),
                    ),
                  ),
                ),

                /// for about/Occupation enter
                Container(
                  margin: const EdgeInsets.fromLTRB(16,4,16,16),
                  child:  TextFormField(
                    initialValue: widget.user.occupation,
                    onSaved: (val) => APIs.me.occupation = val ?? '',
                    style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: 'Student/Teacher',
                        hintStyle: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),
                        label: Text('Occupation',style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge)),
                    ),
                  ),
                ),

                /// for address
                Container(
                  margin: const EdgeInsets.fromLTRB(16,4,16,16),
                  child:  TextFormField(
                    initialValue: widget.user.address,
                    onSaved: (val) => APIs.me.address = val ?? '',
                    style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Enter your address',
                      hintStyle: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),
                      label: Text('Address',style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge)),
                    ),
                  ),
                ),

                /// for about/bio enter
                Container(
                  margin: const EdgeInsets.fromLTRB(16,4,16,16),
                  child:  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? '',
                    style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Say something about you',
                      hintStyle: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),
                      label: Text('Bio',style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge)),
                    ),
                  ),
                ),



                // for adding some space
                SizedBox(height: mq.height * .03),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(text: 'Save', onTap: (){
                    if (_formKey.currentState!.validate()) {
                      DialogHelper.showLoading();
                      _formKey.currentState!.save();
                      APIs.updateUserInfo().then((value) {
                        DialogHelper.hideLoading();
                        Get.back();
                        myToast('Profile Updated Successfully!');
                      });
                    }
                  }),
                ),
                SizedBox(height: mq.height * .05),
              ],
            ),
          )),
    );
  }

  // bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: mq.height * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.image)),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.camera)),
                ],
              )
            ],
          );
        });
  }
}
