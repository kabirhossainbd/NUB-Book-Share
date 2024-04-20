import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> customImagePickFile() async {
  var allAccepted = true;
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  Map<Permission, PermissionStatus> statuses;

  if(androidInfo.version.sdkInt<= 32){
    statuses = await [Permission.storage].request();
  }else{
    statuses = await [Permission.photos, Permission.videos, Permission.audio].request();
  }


  statuses.forEach((permission, status) {
    if(status != PermissionStatus.granted){
      allAccepted = false;
    }else if(status == PermissionStatus.denied){
      allAccepted = false;
    }else if(status == PermissionStatus.permanentlyDenied){
      openSettingsDialog(Get.context);
    }
  });

  if(allAccepted){
    return true;
  }else{
    for (var element in statuses.values) {
      if(element.isDenied){
        if(androidInfo.version.sdkInt <= 32){
          openSettingsDialog(Get.context);
        }else{
          openSettingsDialog(Get.context);
        }
        break;
      }else if(element.isPermanentlyDenied){
        //element = await Permission.photos.request();
        openSettingsDialog(Get.context);
        break;
      }
      return false;
    }}
  return allAccepted;
}


/// for permanentely deny
openSettingsDialog(context) { showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: MyColor.getBackgroundColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  Text('Your Permission is Permanently Denied, so you can to go settings and open permission manually', style: robotoRegular.copyWith(color: MyColor.getTextColor()), textAlign: TextAlign.center,),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => {
                            Navigator.pop(context)},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColor.getPrimaryColor()),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child:  Text('Cancel', style: robotoRegular.copyWith(color: MyColor.getTextColor()),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            //Get.find<SetLocationController>().toggleDiaglue(true ) ;
                            Navigator.pop(context);
                            await openAppSettings();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: MyColor.getPrimaryColor(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('Open Settings',
                              style: robotoRegular.copyWith(color: MyColor.getBackgroundColor()), overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
);
}
