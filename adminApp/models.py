from django.db import models
from django.contrib.auth.models import AbstractUser, AbstractBaseUser
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
# Create your models here.
class SiteStats(models.Model):
    #this is the site stats that holds the status of the site at a particular time
    logDate = models.DateTimeField(auto_now=True) # the log date
    stdCount = models.IntegerField(default=0, null=True) # the student count
    courseCount = models.IntegerField(default=0, null=True) # the course count
    insCount = models.IntegerField(default=0, null=True) # theinstructor count  
    certCount = models.IntegerField(default=0, null=True) # the certificates issued
    def __str__(self):
        return str(self.logDate)

class UserProfile(AbstractUser):
    #is_student = models.BooleanField(null=True)
    is_instructor = models.BooleanField(null=True)
    
    #is_adminstrator = models.BooleanField(null=True)
    #is_active = models.BooleanField(default=True)


class Instructor(models.Model):
    instructor = models.OneToOneField(UserProfile, on_delete=models.CASCADE, related_name='instructor', default='')
    profile_pic = models.ImageField(upload_to='media/profilePics', default='')
    def __str__(self):
        return self.instructor.first_name + " " + self.instructor.last_name

class InstructorFeedback(models.Model):
    feedbackTitle = models.CharField(max_length=255, default='new feedback')
    feedbackDescription = models.TextField(default='feedback body')
    createdBy = models.ForeignKey(Instructor, on_delete=models.CASCADE, related_name='Feedbacks')
    has_response = models.BooleanField(default='False')

    def __str__(self):
        return self.feedbackTitle
class AdminFeedback(models.Model):
    feedbackTitle = models.CharField(max_length=255)
    feedbackDescription = models.TextField(default='feedback body')
    responseTo = models.ForeignKey(InstructorFeedback, on_delete=models.CASCADE, related_name='response')
    
    def __str__(self):
        return self.feedbackTitle
    
    
