from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.models import User
from adminApp.models import UserProfile, Instructor
# class Instructor(AbstractUser):
#     pass 
#     # contentId=models.ForeignKey(Content,on_delete=models.CASCADE)   
class Preference(models.Model):
    siteLang=models.CharField(max_length=200)
    startLevel=models.CharField(max_length=20)
    currLevel=models.CharField(max_length=20)
    accountType=models.CharField(max_length=200)
class Course(models.Model):
    courseName=models.CharField(max_length=200)
    courseImage=models.FileField(upload_to='courseImages/', max_length=255, null=True)
    instructor=models.ForeignKey(Instructor, on_delete=models.CASCADE, related_name='course', null=True)
    courseDescription=models.TextField()

    
    def __str__(self):
        return self.courseName
class Content(models.Model):
    contentValue=models.TextField()
    contentImage=models.ImageField(upload_to='media/',height_field=None,width_field=None,max_length=500)
    contentAudio=models.FileField(upload_to='media/',max_length=500)
    contentVideo=models.FileField(upload_to='media/',max_length=500)
    course=models.ForeignKey(Course,on_delete=models.CASCADE, default='')
    isComplete=models.BooleanField(null=True)
    # createdBy=models.ForeignKey(Instructor,on_delete=models.CASCADE)


class Quiz(models.Model):
    marks=models.IntegerField()
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE)
    questionDir=models.FilePathField(path='../Questions', max_length=100)
    answerDir=models.FilePathField(path='../Answers',max_length=100)
    scored=models.IntegerField()    

class Certificate(models.Model):
    certDate=models.DateField(auto_now_add=True)
    certUrl=models.URLField(max_length=200)
    courseId=models.OneToOneField(Course,on_delete=models.CASCADE)

class Grade(models.Model):
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE)
    grade=models.IntegerField()
class Student(models.Model):
    student = models.OneToOneField(UserProfile, on_delete=models.CASCADE, null=True)
    prefId=models.ForeignKey(Preference,on_delete=models.CASCADE,null=True,	blank=True)
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE)
    quizId=models.ForeignKey(Quiz,on_delete=models.CASCADE)
    certId=models.OneToOneField(Certificate,on_delete=models.CASCADE)
    gradeId=models.ForeignKey(Grade,on_delete=models.CASCADE)