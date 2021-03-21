from rest_framework import serializers
from .models import Student,Preference,Course,Content,Quiz,Certificate,Grade,Takes

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = ('id', 'first_name','last_name','email','username')
class PreferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model=Preference
        fields=('id','userId','siteLang','currLevel','accountType','currContentId')
class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model=Course
        fields=('id','courseName','courseDescription','courseImage')
class ContentSerializer(serializers.ModelSerializer):
    class Meta:
        model=Content
        fields=('id','contentTitle','contentValue','contentImage','contentAudio','contentVideo','contentLevel')
        # lookup_field='level'
class QuizSerializer(serializers.ModelSerializer):
    class Meta:
        model=Quiz
        fields=('id','marks','courseId','questionDir','answerDir','scored',)
class CertificateSerializer(serializers.ModelSerializer):
    class Meta:
        model=Certificate
        fields=('id','certDate','certUrl','courseId',)
class GradeSerializer(serializers.ModelSerializer):
    class Meta:
        model=Grade
        fields=('id','courseId','grade',)
class TakesSerializer(serializers.ModelSerializer):
    class Meta:
        model=Takes
        fields=('id','contentId','userId','isComplete')