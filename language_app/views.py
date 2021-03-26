from rest_framework import generics,permissions
from .models import Student,Preference,Course,Content,Quiz,Certificate,Grade,Takes,UserProfile,CourseTakes,Status
from .serializers import StatusSerializer,CourseTakesSerializer,ProfileSerializer,CustomRegisterSerializer,TakesSerializer,UserSerializer,PreferenceSerializer,CourseSerializer,ContentSerializer,QuizSerializer,CertificateSerializer,GradeSerializer
from .permissions import ReadOnlyOrIsInstructor,UserPermission,ContentPermission,ReadOnlyOrIsAdmin,ReadOnly
from django_filters.rest_framework import DjangoFilterBackend
from django.http import HttpResponse
from rest_auth.views import UserDetailsView
from rest_auth.registration.views import RegisterView
from django.db import transaction
MaxId=4 #maximum no of content in a level
class CustomRegisterView(RegisterView):
    serializer_class=CustomRegisterSerializer
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        create=self.create(request, *args, **kwargs)
        st=Student()
        profile=UserProfile.objects.last()
        profile.is_instructor=False
        profile.is_staff=False
        profile.save()
        st.student=profile
        st.save()
        return create
class ListUser(generics.ListAPIView):
    permission_classes=(ReadOnlyOrIsAdmin,)
    queryset = Student.objects.all()
    serializer_class = UserSerializer
    def get_queryset(self):
        if self.request.user.is_staff:
            return Student.objects.all()
        try:
            return Student.objects.filter(id=self.request.user.students.id)
        except Exception:
            return None
class DetailUser(generics.RetrieveUpdateDestroyAPIView):
    queryset = Student.objects.all()
    serializer_class = UserSerializer
class ProfileDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset=UserProfile.objects.all()
    serializer_class=ProfileSerializer
class ListPreference(generics.ListCreateAPIView):
    queryset=Preference.objects.all()
    serializer_class=PreferenceSerializer
class DetailPreference(generics.RetrieveUpdateDestroyAPIView):
    queryset=Preference.objects.all()
    serializer_class=PreferenceSerializer
class ListCourse(generics.ListCreateAPIView):
    permission_classes=(ReadOnlyOrIsAdmin,)
    queryset=Course.objects.all()
    serializer_class=CourseSerializer
class DetailCourse(generics.RetrieveUpdateDestroyAPIView):
    permission_classes=(ReadOnlyOrIsAdmin,)
    queryset=Course.objects.all()
    serializer_class=CourseSerializer
class CourseTakesList(generics.CreateAPIView):
    queryset=CourseTakes.objects.all()
    serializer_class=CourseTakesSerializer
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        create=self.create(request, *args, **kwargs)
        cr=CourseTakes.objects.last()
        cr.userId=request.user.students
        cr.save()
        status=Status()
        status.userId=cr.userId
        status.courseTakesId=cr
        status.save()
        return create
class ListStatus(generics.ListAPIView):
    queryset=Status.objects.all()
    serializer_class=StatusSerializer
    def get_queryset(self):
        try:
            return Status.objects.filter(userId=self.request.user.students)
        except Exception:
            return None
class ListContent(generics.ListCreateAPIView):
    permission_classes=(ReadOnlyOrIsInstructor,)
    queryset=Content.objects.all()
    serializer_class=ContentSerializer
    def get_queryset(self):
        try:  
            if self.request.user.is_staff:
                return Content.objects.all()
            return  Content.objects.filter(userId=self.request.user.students)
        except Exception:
            return None
class DetailContent(generics.RetrieveUpdateDestroyAPIView):
    permission_classes=(ReadOnlyOrIsInstructor,)
    queryset=Content.objects.all()
    serializer_class=ContentSerializer
    def get_queryset(self):
        try:
            return  Content.objects.filter(contentLevel=self.request.user.students.statusUserId.currLevel,selfID=self.request.user.students.statusUserId.currContentId)
        except Exception:
            return None
class ListTakes(generics.ListCreateAPIView):
    queryset=Takes.objects.all()
    serializer_class=TakesSerializer
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        create=self.create(request, *args, **kwargs)
        take=Takes.objects.last()
        if take.isComplete==True:
            status= Status.objects.get(userId=self.request.user.students.id,courseTakesId=CourseTakes.objects.get(userId=self.request.user.students,courseId=take.contentId.courseId))
            if status.currContentId==MaxId:
                status.currContentId=1
                status.currLevel=status.currLevel + 1
                status.userId=self.request.user.students
                status.courseTakesId=status.courseTakesId
                status.save()
                return create
            # elif Takes.objects.get(userId=self.request.user,contentId=Preference.objects.get(userId=self.request.user.id).currContentId-1).isComplete:
            status.currContentId=status.currContentId+1
            status.currLevel=status.currLevel
            status.userId=self.request.user.students
            status.courseTakesId=status.courseTakesId
            status.save()
            return create
        return HttpResponse('you have not completed')    
    def get_queryset(self):
        try:
            return Takes.objects.filter(userId=self.request.user.students)
        except Exception:
            return None
class DetailTakes(generics.RetrieveUpdateDestroyAPIView):
    queryset=Takes.objects.all()
    serializer_class=TakesSerializer
class ListQuiz(generics.ListCreateAPIView):
    queryset=Quiz.objects.all()
    serializer_class=QuizSerializer
class DetailQuiz(generics.RetrieveUpdateDestroyAPIView):
    queryset=Quiz.objects.all()
    serializer_class=QuizSerializer
class ListCertificate(generics.ListCreateAPIView):
    queryset=Certificate.objects.all()
    serializer_class=CertificateSerializer
class DetailCertificate(generics.RetrieveUpdateDestroyAPIView):
    permission_classes=(ReadOnly,)
    queryset=Certificate.objects.all()
    serializer_class=CertificateSerializer
class ListGrade(generics.ListCreateAPIView):
    queryset=Grade.objects.all()
    serializer_class=GradeSerializer
class DetailGrade(generics.RetrieveUpdateDestroyAPIView):
    permission_classes=(ReadOnly,)
    queryset=Grade.objects.all()
    serializer_class=GradeSerializer
class ContentInLevelList(generics.ListAPIView):
    queryset = Content.objects.all()
    serializer_class = ContentSerializer
    def get_queryset(self):
        return Content.objects.filter(contentLevel=UserProfile.objects.get(id=self.request.user.id).statusId.currLevel,selfID=UserProfile.objects.get(id=self.request.user.id).statusId.currContentId)
