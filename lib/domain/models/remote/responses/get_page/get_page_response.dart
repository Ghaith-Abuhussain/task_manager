import 'package:equatable/equatable.dart';
import './support.dart';
import './task.dart';

class GetPageResponse extends Equatable {
  final int? page;
  final int? per_page;
  final int? total;
  final int? total_pages;
  final List<TaskResponse>? data;
  final SupportResponse? support;

  GetPageResponse(
      {this.page,
      this.per_page,
      this.total,
      this.total_pages,
      this.data,
      this.support});

  factory GetPageResponse.fromMap(Map<String, dynamic> map) {
    return GetPageResponse(
      page: map['page'] != null ? map['page'] as int : null,
      per_page: map['per_page'] != null ? map['per_page'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
      total_pages:
          map['total_pages'] != null ? map['total_pages'] as int : null,
      data: List<TaskResponse>.from((map['data'] as List<dynamic>)
          .map<TaskResponse>(
              (x) => TaskResponse.fromMap(x as Map<String, dynamic>))),
      support: map['support'] != null
          ? SupportResponse.fromMap(map['support'])
          : null,
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? dat =
        this.data != null ? this.data!.map((i) => i.toJson()).toList() : null;

    return {
      'page': page,
      'per_page': per_page,
      'total': total,
      'total_pages': total_pages,
      'data': dat,
      'support': this.support!.toJson(),
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        page,
        per_page,
        total,
        total_pages,
        data,
        support,
      ];
}
