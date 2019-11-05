import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:front/BDD/DatabaseService.dart';
import 'package:front/Model/sentenceModel.dart';


class kMeans{


  kMeansSentence(){

    distanceMeasure = DistanceType.squaredEuclidian;

    List<SentenceModel> lSM = DatabaseService().getSentenceData();
    List<Instance> instances = lSM.map((datum) {
      String id = datum.timeStamp;
      return Instance([0, datum.score], id:id);
    }).toList();

    List<Cluster> clusters = initialClusters(2, instances);

    kmeans(clusters: clusters, instances: instances);

    for(final cluster in clusters){
      print(cluster.id);
      for(final instance in cluster.instances){
        print(" - $instance");
      }
    }
  }


}