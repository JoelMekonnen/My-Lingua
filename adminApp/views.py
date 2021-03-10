from django.shortcuts import render, redirect
# Create your views here.
from django.http import HttpResponse
from django.views.generic import View, DetailView, ListView, CreateView, UpdateView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin, PermissionRequiredMixin
from .forms import CustomUserCreationForm, CourseForm, ContentForm, FeedBackForm, AdminFeedBackForm   
from django.views.generic.edit import FormView
from .models import SiteStats, Instructor, UserProfile, InstructorFeedback, AdminFeedback
from language_app.models import Course, Content
class HomePage(ListView):
    model = SiteStats
    template_name = 'adminSite/index.html'
    siteStats = SiteStats.objects.last()
    def get(self, request):
        if request.user.is_staff:
            AdminForm = AdminFeedBackForm
            siteFeedback = InstructorFeedback.objects.filter(has_response=False)[:2]
            

            return render(request, self.template_name, {'feedbacks': siteFeedback, 'stats':self.siteStats, 'adminForm':AdminForm})
        if request.user.is_instructor:
            return redirect('instructorHome')
    def post(self, request):
        adminResponseId = int(request.POST['response'])
        form = AdminFeedBackForm(request.POST)
        if request.POST.get('btn_' + str(adminResponseId)):
            if form.is_valid():
                adminResponseForm = form.save(commit=False)
                insFeedback = InstructorFeedback.objects.get(id=adminResponseId)
                insFeedback.has_response = True
                adminResponseForm.responseTo = InstructorFeedback.objects.get(id=adminResponseId)
                insFeedback.save()
                adminResponseForm.save()
        return redirect('home')
        # print(request.POST)

    # def test_func(self):
    #     return self.request.user.is_staff
class InstructorCreate(View):
    form_class = CustomUserCreationForm
    template_name = 'adminSite/instructor.html'
    def get(self, request):
         form = CustomUserCreationForm
         return render(request, self.template_name, {'form':form})
    def post(self, request):
          form = CustomUserCreationForm(request.POST)
          instructor = Instructor()
          if form.is_valid():
              user = form.save(commit=False)   
              #Cleaned (normalized data)
              username = form.cleaned_data['username']
              password = form.cleaned_data['password1']
              user.set_password(password)
              user.save()
              addedInstructor = UserProfile.objects.last()
              instructor.instructor = addedInstructor
              instructor.save(self) 
          return redirect('home')
class CourseCreateView(View):
    template_name = 'adminSite/course.html'
    model = Course
    course_content = Course.objects.all()
    context_object_name = 'courses'
    def get(self, request):
         form = CourseForm
         return render(request, self.template_name, {'form':form, 'courses':self.course_content,})
    def post(self, request):
          form = CourseForm(request.POST)
          if form.is_valid():
              course = form.save(commit=False)   
              #Cleaned (normalized data)
              courseName = form.cleaned_data['courseName']
              courseDescription = form.cleaned_data['courseDescription']
            #   courseImage = form.cleaned_data['courseImage']
              courseInstructor = form.cleaned_data['instructor']
            #   course_obj.courseName = courseName
            #   course_obj.courseDescription = courseDescription
            #   course_obj.courseImage = courseImage
            #   course_obj.instructor = courseInstructor
              course.save()   
          return redirect('course')
class InstructorHomeView(UserPassesTestMixin, FormView):
    template_name = 'adminSite/instructorHome.html'
    model = Content
    fields = ['contentValue', 'contentImage', 'contentVideo', 'contentAudio', 'course']
    form_class = ContentForm
    success_url = 'content'
    def get(self, request):
        content_form = ContentForm
        feedback_form = FeedBackForm
        return render(request, self.template_name, {'form':content_form, 'feedback':feedback_form})
    def post(self, request):
        if request.POST.get('content_btn'):
            form = ContentForm(request.POST, request.FILES)
            if form.is_valid():
                content = form.save(commit=False)  
                #Cleaned (normalized data)
                content.save()
        if request.POST.get('feedback_btn'):
            form = FeedBackForm(request.POST)
            if form.is_valid():
                feedback = form.save(commit=False)
                feedback.createdBy = request.user.instructor
                feedback.save()

        
        return redirect('home')

    def test_func(self):
        return self.request.user.is_instructor





    

    




