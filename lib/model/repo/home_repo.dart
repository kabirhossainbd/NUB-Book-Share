import 'package:get/get.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/src/data/datasource/remote/http_client.dart';

class HomeRequest {
  final ApiClient apiSource;
  HomeRequest({required this.apiSource});

  // Future<Response> getBookList() async {
  //   try {
  //     List<BookModel> itemList = [
  //       BookModel(id: '0', name: 'E-Book', photo: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg", subjectCode: 'CSE-1100',subName: "Soul Book", topicName: 'Soul Adventure', progress: 10, authorName: "Olivia Wilson",createAt: "12-12-20", isFav: true),
  //       BookModel(id: '1', name: 'E-Book', photo: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg", subjectCode: 'CSE-1200',subName: "Soul Book", topicName: 'Soul Adventure', progress: 50, authorName: "Olivia Wilson",createAt: "12-12-24", isFav: false),
  //       BookModel(id: '2', name: 'E-Book', photo: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg", subjectCode: 'CSE-1140',subName: "Soul Book", topicName: 'Soul Adventure', progress: 40, authorName: "Olivia Wilson",createAt: "02-02-23", isFav: true),
  //       BookModel(id: '3', name: 'E-Book', photo: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg", subjectCode: 'CSE-1145',subName: "Soul Book", topicName: 'Soul Adventure', progress: 50, authorName: "Olivia Wilson",createAt: "19-10-21", isFav: false),
  //       BookModel(id: '4', name: 'E-Book', photo: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg", subjectCode: 'CSE-4350',subName: "Soul Book", topicName: 'Soul Adventure', progress: 80, authorName: "Olivia Wilson",createAt: "11-12-22", isFav: false),
  //     ];
  //
  //     Response response = Response(body: itemList, statusCode: 200);
  //     return response;
  //   } catch (e) {
  //     return const Response(statusCode: 404, statusText: 'Item data not found');
  //   }
  // }

}
