import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:interview_task/core/local/sql_helper.dart';
import 'package:interview_task/core/network/custom_exception.dart';
import 'package:interview_task/core/network/http_client.dart';
import 'package:interview_task/core/network/model/random_user_response_model.dart';

abstract class RandomUserService {
  Future<Either<CustomException, RandomUserResponseModel>> getRandomUserList();
}

class RandomUserServiceImpl extends RandomUserService {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<Either<CustomException, RandomUserResponseModel>>
      getRandomUserList() async {
    ConnectivityResult connectionStatus =
        await Connectivity().checkConnectivity();
    if (connectionStatus != ConnectivityResult.none) {
      try {
        final response =
            await _httpClient.get('', queryParameters: {}, headers: {});
        SQLHelper.insertItem(
            RandomUserResponseModel.fromJson(response).results!);
        return Right(RandomUserResponseModel.fromJson(response));
      } catch (e) {
        return Left(CustomException(e.toString()));
      }
    }
    return Left(CustomException('Server Exception'));
  }
}
