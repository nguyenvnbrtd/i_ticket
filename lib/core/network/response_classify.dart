class ResponseClassify<T, E, S> {
  Status status;
  T? data;
  String? error;
  E? event;

  ResponseClassify.start({this.event}) : status = Status.start;

  ResponseClassify.completed(this.data, {this.event})
      : status = Status.completed;

  ResponseClassify.error(this.error, {this.event}) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Data : $data Error : $error";
  }
}

enum Status { start, completed, error }
