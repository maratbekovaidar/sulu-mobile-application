import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';
import 'package:sulu_mobile_application/utils/services/favorite_provider.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  final FavoriteProvider _favoriteProvider= FavoriteProvider();

  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      if(event is FavoriteInitialEvent){

      }



      if(event is FavoriteLoadEvent){
        emit(FavoriteLoading());
        try {
          bool _isFavorite = await _favoriteProvider.getFavoriteStatus(event.branchId);
          emit(FavoriteLoad(_isFavorite));
        } catch(e) {
         emit(FavoriteError());
        }
      }
      if(event is FavoriteSetEvent){
        String result=await makeFavorite(event.branchId);
        if(result =='Салон успешно добавлен в избранные!'){
          emit(FavoriteSet(result));

          emit(FavoriteLoad(true));

        }else{
          emit(FavoriteSet(result));
          emit(FavoriteLoad(false));
        }
        SnackBar snackBar =
        SnackBar(
          content: Text(
              result),
        );
        ScaffoldMessenger.of(
            event.context)
            .showSnackBar(
            snackBar);

      }



    });
  }

  Future<bool> checkFavorite(int id) async{
    return _favoriteProvider.getFavoriteStatus(id);
  }

  Future<String> makeFavorite(int branchId) async {
      if(await _favoriteProvider.getFavoriteStatus(branchId)) {
        return await removeFavorite(branchId);
      }
      else{

        final int codeResult;
        codeResult = await _favoriteProvider.setFavoriteEstablishment(branchId);
        if (codeResult == 200) {
          return 'Салон успешно добавлен в избранные!';
      }else{
          return 'Ошибка при добавлении в избранные';
        }

      }

  }

  Future<String> removeFavorite(int branchId)async{

    if(!await _favoriteProvider.getFavoriteStatus(branchId)) {

      return await makeFavorite(branchId);

    }
    else{

      final int codeResult;

      codeResult = await _favoriteProvider.removeFavoriteEstablishment(branchId);
      if (codeResult == 200) {
        return 'Салон успешно удален из избранных!';


      }else{
        return 'Ошибка удаленных из избранных';
      }


    }
  }



}
