from django import	forms
from django.contrib.auth.forms import UserCreationForm,	UserChangeForm
from .models import UserProfile, Instructor, InstructorFeedback, AdminFeedback
from language_app.models import Course, Content
class CustomUserCreationForm(UserCreationForm):
    class Meta(UserCreationForm.Meta):
        model= UserProfile
        fields= UserCreationForm.Meta.fields + ('first_name', 'last_name', 'email', 'is_instructor',)
class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model=UserProfile
        fields=UserChangeForm.Meta.fields
class CourseForm(forms.ModelForm):
    class Meta:
        model = Course
        fields = ['courseName', 'courseDescription', 'instructor', 'courseImage']

class ContentForm(forms.ModelForm): 
    class Meta:
        model = Content
        fields = ['contentTitle','contentValue', 'contentImage', 'contentVideo', 'contentAudio','contentLevel', 'selfID',]

class FeedBackForm(forms.ModelForm):
    class Meta:
        model = InstructorFeedback
        fields = ['feedbackTitle', 'feedbackDescription']

class AdminFeedBackForm(forms.ModelForm):
    class Meta:
        model = AdminFeedback
        fields = ['feedbackTitle', 'feedbackDescription']

# class UserProfileForm(forms.ModelForm):
#     password = forms.PasswordInput()
#     class Meta:
#         model = Instructor
#         fields = ['username', 'email', 'password', 'is_instructor', 'first_name', 'last_name']
