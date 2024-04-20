import 'package:get/get.dart';
import 'package:nub_book_sharing/model/repo/splash_repo.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRequest splashRepo;
  SplashController({required this.splashRepo});

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }
  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }

}
