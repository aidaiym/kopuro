// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vacancy _$VacancyFromJson(Map<String, dynamic> json) => Vacancy(
      jobTitle: json['jobTitle'] as String,
      companyName: json['companyName'] as String,
      location: json['location'] as String,
      jobType: json['jobType'] as String,
      jobDescription: json['jobDescription'] as String,
      contactInformation: json['contactInformation'] as String,
      salary: json['salary'] as String,
    );

Map<String, dynamic> _$VacancyToJson(Vacancy instance) => <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'companyName': instance.companyName,
      'location': instance.location,
      'jobType': instance.jobType,
      'jobDescription': instance.jobDescription,
      'contactInformation': instance.contactInformation,
      'salary': instance.salary,
    };
