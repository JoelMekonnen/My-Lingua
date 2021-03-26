from django.db import models
from adminApp.models import UserProfile, Instructor

class Student(models.Model):
    student = models.OneToOneField(UserProfile, on_delete=models.CASCADE, null=True,related_name='students')
    profile_pic = models.ImageField(upload_to='profilePics/', default='')
    def __str__(self):
        return self.student.username

class Course(models.Model):
    courseName=models.CharField(max_length=200)
    courseImage=models.FileField(upload_to='courseImages/', max_length=255, null=True)
    instructor=models.ForeignKey(Instructor, on_delete=models.CASCADE, related_name='course', null=True)
    courseDescription=models.TextField()
    def __str__(self):
        return self.courseName
class CourseTakes(models.Model): # table
    userId=models.ForeignKey(Student,on_delete=models.CASCADE,null=True)
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE,related_name='courseTakesId')
    isComplete=models.BooleanField(default=False)

class Content(models.Model):
    userId=models.ManyToManyField(Student,through='Takes',through_fields=('contentId','userId'),)
    contentTitle=models.CharField(max_length=200,default="")
    contentValue=models.TextField()
    contentImage=models.ImageField(upload_to='media/',height_field=None,width_field=None,max_length=500)
    contentAudio=models.FileField(upload_to='media/',max_length=500)
    contentVideo=models.FileField(upload_to='media/',max_length=500)
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE, default='')
    contentLevel=models.IntegerField(default=1)
    selfID=models.IntegerField(default=1)
    createdBy=models.ForeignKey(Instructor,on_delete=models.CASCADE,null=True)
    def __str__(self):
        return self.courseId.courseName+' lecture ' +str(self.contentLevel)+'.'+str(self.selfID)
class Preference(models.Model):
    siteLang=models.CharField(max_length=200)
    accountType=models.CharField(max_length=200)
    userId = models.OneToOneField(Student, on_delete=models.CASCADE, related_name='prefId', default='')
    def __str__(self):
        return self.siteLang
class Status(models.Model):
    userId = models.ForeignKey(Student, on_delete=models.CASCADE, related_name='statusUserId', default='')
    courseTakesId=models.ForeignKey(CourseTakes,on_delete=models.CASCADE, default='',related_name='statusCourseId')
    currLevel=models.IntegerField(default=1)
    currContentId=models.IntegerField(default=1)



class Quiz(models.Model):
    marks=models.IntegerField(null=True)
    courseId=models.ForeignKey(Course,on_delete=models.CASCADE)
    questionDir=models.FileField(upload_to='Questions/', max_length=100)
    level = models.IntegerField()
    quizID=models.IntegerField(default=1)
    userId=models.ManyToManyField(Student,through='QuizTakes',through_fields=('quizId','userId'),)

    def __str__(self):
        return self.courseId.courseName + "_level_" + str(self.level)+ "_ID_" + str(self.quizID)
class QuizTakes(models.Model):
    class Meta:
        unique_together=(('quizId','userId'))
    quizId=models.ForeignKey(Quiz,on_delete=models.CASCADE,related_name='quiztakesId')
    userId=models.ForeignKey(Student,on_delete=models.CASCADE,related_name='quiztakesId')
    scored=models.IntegerField(null=True)
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
    contentId=models.ForeignKey(Content,on_delete=models.CASCADE,null=True,related_name='takesContentId')
    userId=models.ForeignKey(Student,on_delete=models.CASCADE,null=True,related_name='takesUserId')
    isComplete=models.BooleanField(default=False)
    # statusTakes=models.IntegerField(default=2)
    def __str__(self):
        return str(self.userId.student.username)
