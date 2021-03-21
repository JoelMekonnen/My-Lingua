from django.db import models
from adminApp.models import UserProfile, Instructor

class Student(models.Model):
    student = models.OneToOneField(UserProfile, on_delete=models.CASCADE, null=True)
    profile_pic = models.ImageField(upload_to='media/profilePics', default='')

class Course(models.Model):
    courseName=models.CharField(max_length=200)
    courseImage=models.FileField(upload_to='courseImages/', max_length=255, null=True)
    instructor=models.ForeignKey(Instructor, on_delete=models.CASCADE, related_name='course', null=True)
    courseDescription=models.TextField()
    def __str__(self):
        return self.courseName
class Content(models.Model):
    contentTitle=models.CharField(max_length=200,default="")
    contentValue=models.TextField()
    contentImage=models.ImageField(upload_to='media/',height_field=None,width_field=None,max_length=500)
    contentAudio=models.FileField(upload_to='media/',max_length=500)
    contentVideo=models.FileField(upload_to='media/',max_length=500)
    course=models.ForeignKey(Course,on_delete=models.CASCADE, default='')
    contentLevel=models.IntegerField(default=0)
    selfID=models.IntegerField(default=0)
class Preference(models.Model):
    siteLang=models.CharField(max_length=200)
    #startLevel=models.CharField(max_length=20)
    currLevel=models.CharField(max_length=20)
    currContentId=models.ForeignKey(Content, on_delete=models.CASCADE, related_name='prefId',default='')
    accountType=models.CharField(max_length=200)
    userId = models.OneToOneField(Student, on_delete=models.CASCADE, related_name='prefId', default='')
    def __str__(self):
        return self.siteLang
    # isComplete=models.BooleanField(null=True)
    # createdBy=models.ForeignKey(Instructor,on_delete=models.CASCADE)


class Quiz(models.Model):
    marks=models.IntegerField()
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE)
    questionDir=models.FilePathField(path='../Questions', max_length=100)
    level = models.IntegerField(default=0)
    #answerDir=models.FilePathField(path='../Answers',max_length=100)
    #scored=models.IntegerField()    

class Certificate(models.Model):
    certDate=models.DateField(auto_now_add=True)
    certUrl=models.URLField(max_length=200)
    courseId=models.OneToOneField(Course,on_delete=models.CASCADE)
    userId = models.OneToOneField(Student, on_delete=models.CASCADE, related_name='certId', default='')
    
class Grade(models.Model):
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE)
    grade=models.IntegerField()
    userId = models.OneToOneField(Student, on_delete=models.CASCADE, related_name='gradeId', default='')

class Takes(models.Model):
    class Meta:
        unique_together=(('contentId','userId'))
    contentId=models.ForeignKey(Content,on_delete=models.CASCADE,null=True)
    userId=models.ForeignKey(Student,on_delete=models.CASCADE,null=True)
    isComplete=models.BooleanField(default=False)
    def __str__(self):
        return str(self.userId.username)
