import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

import 'network_info_converter.dart';
import 'network_info_json.dart';

export 'network_info_converter.dart';

class ChainsSource {
  final http.Client httpClient;

  final NetworkInfoConverter converter;

  ChainsSource({
    @required this.httpClient,
    @required this.converter,
  })  : assert(httpClient != null),
        assert(converter != null);

  /// Allows to retrieve the list of all the supported chains.
  Future<List<NetworkInfo>> getChains() async {
    final apiUrl =
        "https://raw.githubusercontent.com/RiccardoM/CosmosHub-Chains/master/chains.json";

    final response = await httpClient.get(apiUrl);
    if (response.statusCode == 200) {
      // If the serve returns OK, parse the JSON
      final chainsInfoList = json.decode(response.body) as List;

      // Get the JSON objects
      final chainsInfoJsons = chainsInfoList
          .map((object) => NetworkInfoJson.fromJson(object))
          .toList();

      // Get the real NetworkInfo entities
      final chains =
          chainsInfoJsons.map((info) => converter.convert(info)).toList();

      // Sort based on the id
      chains.sort((a, b) => a.id.compareTo(b.id));
      return chains;
    } else {
      // If the response was not OK, throw an error
      throw Exception("Failed to load chains list");
    }
  }

  /// Allows to retrieve the chain having the given id.
  /// Throws exception if no chain is found.
  /// TODO: This should have a dedicated endpoint and not the list every time
  /// TODO: Maybe add a local database for faster loading?
  Future<NetworkInfo> getChainById(String chainId) async {
    final chains = await getChains();
    final chainsData = chains.where((chain) => chain.id == chainId).toList();

    if (chainsData.isEmpty) {
      throw Exception("Chain with id $chainId not supported");
    } else {
      return chainsData[0];
    }
  }
}
