from django.shortcuts import render, redirect
from django.urls import reverse_lazy
# Create your views here.
from django.http import HttpResponse
from django.views.generic import View, DetailView, ListView, CreateView, UpdateView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin, PermissionRequiredMixin
from .forms import CustomUserCreationForm, CourseForm, ContentForm, FeedBackForm, AdminFeedBackForm   
from django.views.generic.edit import FormView
from .models import SiteStats, Instructor, UserProfile, InstructorFeedback, AdminFeedback
from language_app.models import Course, Content
from .create_quiz import Converter
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
         availUser = UserProfile.objects.filter(is_instructor=True)
         return render(request, self.template_name, {'form':form, 'users':availUser})
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
class CourseCreateView(UserPassesTestMixin, View):
    template_name = 'adminSite/course.html'
    model = Course
    course_content = Course.objects.all()[:4]
    context_object_name = 'courses'
    def get(self, request):
         form = CourseForm
         return render(request, self.template_name, {'form':form, 'courses':self.course_content,})
    def post(self, request):
          if request.POST.get('courseSubmit'):
            form = CourseForm(request.POST, request.FILES)
            if form.is_valid():
                course = form.save(commit=False)   
                #Cleaned (normalized data)
                print(course)
                course.save()   
          return redirect('course')
    def test_func(self):
        return self.request.user.is_staff
class ContentCreateView(UserPassesTestMixin, FormView):
    template_name = 'adminSite/ContentCreate.html'
    model = Content
    fields = ['contentValue', 'contentImage', 'contentVideo', 'contentAudio', 'courseId', 'contentLevel', 'selfID']
    #form_class = ContentForm
    #success_url = 'contentCreate'
    courseSelected = Course()
    def get(self, request, pk):
        content_form = ContentForm
        feedback_form = FeedBackForm
        teaches = Course.objects.filter(instructor=self.request.user.instructor)
        self.courseSelected = Course.objects.get(id=pk)
        return render(request, self.template_name, {'form':content_form, 'feedback':feedback_form, 'teaches':teaches})
    def post(self, request, pk):
        if request.POST.get('content_btn'):
            Mainform = ContentForm(request.POST, request.FILES)
            print(request.POST)
            print(request.FILES)
            if Mainform.is_valid():
                print('Form is valid')
                content = Mainform.save(commit=False)  
                #Cleaned (normalized data)
                courseSelected = Course.objects.get(id=pk)
                content.createdBy = request.user.instructor
                content.courseId = courseSelected
                print(request.POST)
                content.save()
            else:
                print('form is not valid')
            return redirect('instructorHome')
        if request.POST.get('feedback_btn'):
            form = FeedBackForm(request.POST)
            if form.is_valid():
                feedback = form.save(commit=False)
                feedback.createdBy = request.user.instructor
                feedback.save()

        
        return redirect('home')

    def test_func(self):
        return self.request.user.is_instructor
class InstructorHomeView(UserPassesTestMixin, View):
    template_name = 'adminSite/homepage_ins.html'
    def get(self, request):
        courseList = Course.objects.filter(instructor=self.request.user.instructor)
        return render(request, self.template_name, {'courses':courseList})
    def test_func(self):
        return self.request.user.is_instructor
    
class CourseListView(ListView):
    model = Course
    template_name = 'adminSite/courseList.html'
    context_object_name = 'courses'

class CourseUpdateView(UpdateView):
    model = Course
    template_name = 'adminSite/updateList.html'
    success_url = reverse_lazy('courseList')
    fields = ['courseName', 'courseImage', 'courseDescription']
    context_object_name = 'courses'

class CreateQuiz(View):
    template_name='adminSite/quizCreate.html'
    nu = range(2)
    choices = ['a', 'b', 'c', 'd']
    questions = list()
   
    def get(self, request, pk):
        courseList = Course.objects.filter(instructor=request.user.instructor)
        return render(request, self.template_name, {'courses':courseList})
        #return render(request, self.template_name, {'nu':self.nu, 'choices':self.choices})
    def post(self, request):
        fullQuestion = {}
        if request.POST.get('btn_sub'):
            # print(request.POST)
            for quesNum in self.nu:
                choose = dict()
                questionVal = request.POST['question_' + str(quesNum)]
                for choice in self.choices:
                    
                    print(str(quesNum) + choice)
                    choose[choice] = request.POST.__getitem__(str(quesNum)+choice)
                
                fullQuestion[quesNum] = { 
                        'question':questionVal,
                        'choices': choose,
                }
            self.questions.append(fullQuestion)
            myConvert = Converter(self.questions, 'output_1.json')
            myConvert.convert()
            myConvert.showVal()
            return redirect('createQuiz')








    

    




