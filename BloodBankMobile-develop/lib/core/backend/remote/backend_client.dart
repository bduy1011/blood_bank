import 'package:blood_donation/models/blood_donation_event.dart';
import 'package:blood_donation/models/district.dart';
import 'package:blood_donation/models/general_response.dart';
import 'package:blood_donation/models/province.dart';
import 'package:blood_donation/models/question.dart';
import 'package:blood_donation/models/register_donation_blood_response.dart';
import 'package:blood_donation/models/slide_model.dart';
import 'package:blood_donation/models/system_config.dart';
import 'package:blood_donation/models/ward.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/authentication_response.dart';
import '../../../models/blood_donor.dart';
import '../../../models/blood_type.dart';
import '../../../models/cau_hinh_ton_kho_view.dart';
import '../../../models/dm_don_vi_cap_mau_response.dart';
import '../../../models/donation_blood_history_response.dart';
import '../../../models/feedback_respose.dart';
import '../../../models/giao_dich_template.dart';
import '../../../models/giaodich_response.dart';
import '../../../models/news_response.dart';
import '../../../models/register_donation_blood_history_response.dart';
import '../../../models/register_reponse.dart';

part 'backend_client.g.dart';

@RestApi()
abstract class BackendClient {
  factory BackendClient(Dio dio, {String baseUrl}) = _BackendClient;

  @POST('api/system-user/login')
  Future<AuthenticationResponse> login(@Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @GET('api/system-user/refresh-token')
  Future<String> refreshToken();
  @GET('api/system-user/re-load-information')
  Future<AuthenticationResponse> reLoadInformation();

  @POST('api/system-user/register')
  Future<GeneralResponseMap<RegisterResponse>> register(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});

  @POST('api/system-user/register-phone')
  Future<GeneralResponseMap> registerByPhone(@Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @POST('api/system-user/check-otp')
  Future<AuthenticationResponse> checkOtp(@Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});

  @POST('api/system-user/resend-otp')
  Future<GeneralResponseMap> resendOtp(@Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});

  @POST('api/system-user/change-password/false')
  Future<GeneralResponseMap> changePassword(@Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});

  @POST('api/system-user/change-password/true')
  Future<GeneralResponseMap> changePasswordByRegister(
      @Body() Map<String, dynamic> body, @Header("Authorization") String token,
      {@DioOptions() Options? options});

  @PUT('api/system-user/update/{code}/{isModIdCard}')
  Future<GeneralResponseMap<RegisterResponse>> updateUser(
      @Body() Map<String, dynamic> body,
      @Path("code") String code,
      @Path("isModIdCard") bool isModIdCard,
      {@DioOptions() Options? options});

  @DELETE('api/system-user/delete-account/{code}')
  Future<GeneralResponseMap> deleteAccount(@Path("code") String code,
      {@DioOptions() Options? options});

  @GET('api/system-user/logout')
  Future<GeneralResponseMap> logout({@DioOptions() Options? options});

  @GET('api/dm-chung/load-nhom-mau')
  Future<GeneralResponse<BloodType>> getBloodTypes(
      {@DioOptions() Options? options});

  @POST('api/dm-don-vi-cap-mau/load')
  Future<GeneralResponse<DmDonViCapMauResponse>> getDmDonViCapMau(
      {@DioOptions() Options? options});
  @GET('api/cau-hinh-ton-kho/init?ngay={ngay}')
  Future<GeneralResponseMap<CauHinhTonKho>> initTonKhoTemplate(
      @Path("ngay") String ngay,
      {@DioOptions() Options? options});

  @POST('api/cau-hinh-ton-kho')
  Future<GeneralResponseMap> createTonKho(@Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});

  @PUT('api/cau-hinh-ton-kho/{id}')
  Future<GeneralResponseMap> updateTonKho(
      @Body() Map<String, dynamic> body, @Path("id") String id,
      {@DioOptions() Options? options});

  @PATCH('api/cau-hinh-ton-kho')
  Future<GeneralResponse<CauHinhTonKho>> getTonKho(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});

  @GET('api/cau-hinh-ton-kho/{id}')
  Future<GeneralResponseMap<CauHinhTonKho>> getTonKhoById(@Path("id") String id,
      {@DioOptions() Options? options});

  @GET('api/giao-dich/init/{loaiPhieu}')
  Future<GeneralResponseMap<GiaoDichTemplate>> getTemplateNhuongMau(
      @Path("loaiPhieu") String loaiPhieu,
      {@DioOptions() Options? options});

  @POST('api/giao-dich/create')
  Future<GeneralResponseMap> createGiaoDich(@Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});

  @PUT('api/giao-dich/update/{id}/{isApprove}')
  Future<GeneralResponseMap> updateGiaoDich(@Path("id") String id,
      @Path("isApprove") bool isApprove, @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @PUT('api/giao-dich/update/{id}/{isApprove}')
  Future<GeneralResponseMap> approveGiaoDich(@Path("id") String id,
      @Path("isApprove") bool isApprove, @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @PUT('api/giao-dich/update/{id}/{isApprove}')
  Future<GeneralResponseMap> cancelGiaoDich(@Path("id") String id,
      @Path("isApprove") bool isApprove, @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @GET('api/giao-dich/get?id={id}')
  Future<GeneralResponseMap<GiaoDichTemplate>> getGiaoDichById(
      @Path("id") String id,
      {@DioOptions() Options? options});
  @POST('api/giao-dich/load')
  Future<GeneralResponse<GiaodichResponse>> loadGiaoDich(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @DELETE('api/giao-dich/delete/{id}')
  Future<GeneralResponseMap> deleteGiaoDich(@Path("id") String id,
      {@DioOptions() Options? options});

  @GET('api/dm-chung/load-xa')
  Future<GeneralResponse<Ward>> getWards({@DioOptions() Options? options});
  @GET('api/dm-chung/load-tinh')
  Future<GeneralResponse<Province>> getProvinces(
      {@DioOptions() Options? options});
  @GET('api/dm-chung/load-quan')
  Future<GeneralResponse<District>> getDictricts(
      {@DioOptions() Options? options});
  @POST('api/dot-lay-mau/load')
  Future<GeneralResponse<BloodDonationEvent>> getBloodDonationEvents(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @POST('api/system-config/load')
  Future<GeneralResponse<SystemConfig>> getSystemConfig(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @POST('api/system-slide/load')
  Future<GeneralResponse<SlideModel>> getSystemSlides(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @GET('api/tin-tuc/load')
  Future<GeneralResponse<NewsResponse>> getNews(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @GET('api/tin-tuc/get/{id}')
  Future<GeneralResponseMap<NewsResponse>> getNewsById(@Path("id") String id,
      {@DioOptions() Options? options});
  @GET('api/dm-chung/load-bang-cau-hoi')
  Future<List<Question>> getQuestions({@DioOptions() Options? options});
  @POST('api/dang-ky-hien-mau/create')
  Future<RegisterDonationBloodResponse> registerDonateBlood(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @POST('api/dang-ky-hien-mau/load')
  Future<GeneralResponse<RegisterDonationBloodHistoryResponse>>
      registerDonateBloodHistory(@Body() Map<String, dynamic> body,
          {@DioOptions() Options? options});
  @GET('api/dang-ky-hien-mau/get/{id}')
  Future<GeneralResponseMap<RegisterDonationBloodHistoryResponse>>
      getRegisterDonateBloodById(@Path("id") String id,
          {@DioOptions() Options? options});
  @POST('api/lich-su-hien-mau/load')
  Future<GeneralResponse<DonationBloodHistoryResponse>> donateBloodHistory(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @PUT('api/dang-ky-hien-mau/update/{id}')
  Future<GeneralResponseMap<RegisterDonationBloodHistoryResponse>>
      cancelRegisterDonateBlood(
          @Body() Map<String, dynamic> body, @Path("id") String id,
          {@DioOptions() Options? options});
  @GET('api/dm-nguoi-hien-mau/get/{identityCard}?phoneNumber={phoneNumber}')
  Future<GeneralResponseMap<BloodDonor>> getDMNguoiHienMauByIdCard(
      @Path("identityCard") String identityCard,
      @Path("phoneNumber") String phoneNumber,
      {@DioOptions() Options? options});
  @POST('api/gop-y/create')
  Future<GeneralResponseMap<dynamic>> createGopY(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  @POST('api/gop-y/load')
  Future<GeneralResponse<FeedbackResponse>> getGopY(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
  // dm-nguoi-hien-mau/get/352840850?phoneNumber=123
  // @PUT('/api/dm-nguoi-hien-mau/mapping')
  // Future<GeneralResponse> updateProfile(@Body() Map<String, dynamic> body,
  //     {@DioOptions() Options? options});
  @Header("accept: */*")
  @GET('api/files-manage/get-letter/{id}/{type}')
  Future<String> getLetter(@Path("id") String id, @Path("type") String type,
      {@DioOptions() Options? options});

  @POST('api/system-user/tao-yeu-cau-cap-mk')
  Future<GeneralResponseMap<dynamic>> requestForgotPassword(
      @Body() Map<String, dynamic> body,
      {@DioOptions() Options? options});
}
