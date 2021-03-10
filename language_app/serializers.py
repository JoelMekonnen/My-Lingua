from rest_framework import serializers
from .models import Student,Preference,Course,Content,Quiz,Certificate,Grade

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = ('id', 'first_name','last_name','email','username','prefId','courseId','quizId','certId','gradeId',)
class PreferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model=Preference
        fields=('id','siteLang','startLevel','currLevel','accountType',)
class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model=Course
        fields=('id','courseName','courseDescription','contents', 'courseImage')
class ContentSerializer(serializers.ModelSerializer):
    class Meta:
        model=Content
        fields=('id','contentValue','contentImage','contentAudio','contentVideo','isComplete',)
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
        fields=('id','courseId','userId','grade',)