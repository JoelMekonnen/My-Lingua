from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
# from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import	Student,Preference,Course,Content,Quiz,Certificate,Grade
admin.site.register(Student)
admin.site.register(Preference)
admin.site.register(Course)
admin.site.register(Content)
admin.site.register(Quiz)
admin.site.register(Certificate)
admin.site.register(Grade)