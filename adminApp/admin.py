from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Instructor, SiteStats, UserProfile, InstructorFeedback, AdminFeedback
from .forms import CustomUserCreationForm, CustomUserChangeForm

class CustomUserAdmin(UserAdmin):
    add_form=CustomUserCreationForm
    form=CustomUserChangeForm
    model=UserProfile
    list_display=['first_name','last_name','email','username','is_instructor',]
# Register your models here.
admin.site.register(Instructor)
admin.site.register(SiteStats)
admin.site.register(UserProfile, CustomUserAdmin)
admin.site.register(InstructorFeedback)
admin.site.register(AdminFeedback)