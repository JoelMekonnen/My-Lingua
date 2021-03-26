from rest_framework import serializers
from .models import Status,Student,Preference,Course,Content,Quiz,Certificate,Grade,Takes,CourseTakes
from adminApp.models import UserProfile
from rest_auth.serializers import UserDetailsSerializer
from rest_auth.registration.serializers import RegisterSerializer
from django.db import transaction
#from drf_writable_nested import WritableNestedModelSerializer


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields=['id','first_name','last_name','username','email']
class UserSerializer(serializers.ModelSerializer):
    student=ProfileSerializer(many=False,read_only=True)
    class Meta:
        model = Student
        fields = ('id','student','profile_pic')

class PreferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model=Preference
        fields='__all__'
class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model=Course
        fields='__all__'
class ContentSerializer(serializers.ModelSerializer):
    class Meta:
        model=Content
        fields=['contentTitle','contentValue','contentImage','contentImage','contentAudio','contentVideo','courseId','contentLevel','selfID','createdBy']
        # lookup_field='level'
class QuizSerializer(serializers.ModelSerializer):
    class Meta:
        model=Quiz
        fields='__all__'
class CertificateSerializer(serializers.ModelSerializer):
    class Meta:
        model=Certificate
        fields='__all__'
class GradeSerializer(serializers.ModelSerializer):
    class Meta:
        model=Grade
        fields='__all__'
class TakesSerializer(serializers.ModelSerializer):
    class Meta:
        model=Takes
        fields='__all__'
class CustomRegisterSerializer(RegisterSerializer):
    class Meta:
        model=UserProfile
        fields='__all__'
class CourseTakesSerializer(serializers.ModelSerializer):
    class Meta:
        model=CourseTakes
        fields=['courseId']
class StatusSerializer(serializers.ModelSerializer):
    class Meta:
        model=Status
        fields='__all__'