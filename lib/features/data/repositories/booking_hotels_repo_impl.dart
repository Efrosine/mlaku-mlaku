import 'package:mlaku_mlaku/core/datastate/datastate.dart';
import 'package:mlaku_mlaku/features/data/datasources/api/booking_hotels_service.dart';
import 'package:mlaku_mlaku/features/data/datasources/firebase/cloud_service.dart';
import 'package:mlaku_mlaku/features/data/model/hotel_model.dart';
import 'package:mlaku_mlaku/features/data/model/req_hotels_model.dart';
import 'package:mlaku_mlaku/features/domain/entities/hotels_ent.dart';
import 'package:mlaku_mlaku/features/domain/entities/req_booking_ent.dart';
import 'package:mlaku_mlaku/features/domain/repositories/booking_hotels_repo.dart';

class BookingHotelsRepoImpl extends BookingHotelsRepo {
  BookingHotelsRepoImpl(this._hotelsService, this._cloudService);

  final BookingHotelsService _hotelsService;
  final CloudService _cloudService;

  @override
  Future<DataState<HotelsEntity, void>> getDetailHotels(HotelsEntity hotelsEntity) async {
    try {
      final respose =
          await _hotelsService.getDetailHotes(HotelsModel.fromEntity(hotelsEntity));
      final data = respose.data['data'][0];
      final result =
          hotelsEntity.copyWith(HotelsEntity(description: data['description']));
      return DataSuccess(result);
    } catch (e) {
      return const DataError(null);
    }
  }

  @override
  Future<DataState<List<HotelsEntity>, void>> getListHotels(
      ReqBookingEntity regBookingEnt) async {
    try {
      final respon =
          await _hotelsService.getListHotels(ReqBookingModel.fromEntity(regBookingEnt));
      final data = respon.data['data']['hotels'] as List;
      final result = data.map((e) => HotelsModel.fromJson(e)).toList();
      return DataSuccess(result);
    } catch (e) {
      print('data error $e');
      return const DataError(null);
    }
  }

  @override
  Future<DataState<void, void>> setReservation(HotelsEntity hotelsEntity) async {
    try {
      final respon =
          await _cloudService.addReservation(HotelsModel.fromEntity(hotelsEntity));
      print('penambahan berhasil');
      return const DataSuccess(null);
    } catch (e) {
      print('penambahan error $e');
      return const DataError(null);
    }
  }
  
  @override
  Future<DataState<List<HotelsEntity>, void>> getAllReservation() {
    // TODO: implement getAllReservation
    throw UnimplementedError();
  }

  // @override
  // Future<DataState<List<HotelsEntity>, void>> getAllReservation() async {
  //   try {
  //     final data = await _cloudService.getAllReservation();
  //     List<HotelsEntity> listHotels = [];
  //     for (var element in data.docs) {
  //       var et = element.data() as Map<String, dynamic>;
  //       listHotels.add(HotelsModel.fromJson(et));
  //     }
  //     for (var element in listHotels) {
  //       print(element.id);
  //     }
  //     return DataSuccess(listHotels);
  //   } catch (e) {
  //     print('data error $e');
  //     return const DataError(null);
  //   }
  // }
}
