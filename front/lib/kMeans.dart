import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:front/BDD/DatabaseService.dart';
import 'package:front/Model/scoreModel.dart';

import 'package:flutter/material.dart';

import 'package:front/endOk.dart';
import 'package:front/endNok.dart';
class kMeans{

  bool found;
  String type;
  String id;
  List<Instance> instances = new List();

  StatefulWidget kMeansScore(score){

    List<ScoreModel> scores = DatabaseService( ).scores;

    print(scores.length);
    instances = scores.map((datum) {
      String id = datum.drunk.toString();
      return Instance([0, datum.score], id:id);
    }).toList();

    instances.add(Instance([0, score], id:"new"));
    List<Cluster> clusters = initialClusters(2, instances);

    kmeans(clusters: clusters, instances: instances);

    for(final cluster in clusters){
      print(cluster.id);
      for(final instance in cluster.instances){
        if(instance.id == "new"){
          id = cluster.id;
        }
        print(" - $instance");
      }
    }

    var drunk = 0;
    var notdrunk = 0;


    for(final cluster in clusters){
      if(cluster.id==id){
        for(final instance in cluster.instances){
          if(instance.id == "true"){
            drunk++;
          }else if(instance.id == "false"){
            notdrunk++;
          }
        }
      }
    }

    if(notdrunk>drunk)
      return EndOk();
    else
      return EndNOk();

  }


}