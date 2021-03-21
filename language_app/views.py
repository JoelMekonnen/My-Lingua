from rest_framework import generics,permissions
from .models import Student,Preference,Course,Content,Quiz,Certificate,Grade,Takes
from .serializers import TakesSerializer,UserSerializer,PreferenceSerializer,CourseSerializer,ContentSerializer,QuizSerializer,CertificateSerializer,GradeSerializer
from .permissions import UserPermission,ContentPermission,ReadOnlyOrIsAdmin,ReadOnly
from django_filters.rest_framework import DjangoFilterBackend
from django.http import HttpResponse
class ListUser(generics.ListCreateAPIView):
    permission_classes=(permissions.IsAdminUser,)
    queryset = Student.objects.all()
    serializer_class = UserSerializer
class DetailUser(generics.RetrieveUpdateDestroyAPIView):
    permission_classes=(UserPermission,)
    queryset = Student.objects.all()
    serializer_class = UserSerializer
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
    queryset=Course.objects.all()
    serializer_class=CourseSerializer
class ListContent(generics.ListCreateAPIView):
    # permission_classes=(permissions.IsAdminUser,)
    queryset=Content.objects.all()
    serializer_class=ContentSerializer
    def get_queryset(self):
        if self.request.user.is_staff:
            return Content.objects.all()
        return  Content.objects.filter(Takes.objects.filter(userId=Content.objects.get))
class DetailContent(generics.RetrieveUpdateDestroyAPIView):
    queryset=Content.objects.all()
    serializer_class=ContentSerializer
    def get_queryset(self):
        return  Content.objects.filter(selfID=Preference.objects.get(id=self.request.user.prefId.id).currContentId)

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
        return Content.objects.filter(level=Student.objects.get(id=self.request.user.id).prefId.currLevel,id=Student.objects.get(id=self.request.user.id).prefId.currContentId)
class ListTakes(generics.ListCreateAPIView):
    queryset=Takes.objects.all()
    serializer_class=TakesSerializer
    def post(self, request, *args, **kwargs):
        return HttpResponse(False)
        pref = Preference()
        pref.id= Preference.objects.get( userId=self.request.user.id).id
        if request.user.prefId.currContentId==1:
            pref.siteLang=Preference.objects.get(userId=self.request.user.id).siteLang
            pref.accountType=Preference.objects.get(userId=self.request.user.id).accountType
            pref.currContentId=2
            pref.currLevel=Content.objects.get(id=pref.currContentId).level
            pref.userId=self.request.user
            pref.save()
            return self.create(request, *args, **kwargs)
        elif Takes.objects.get(userId=self.request.user.id,contentId=Preference.objects.get(userId=self.request.user.id).currContentId-1).isComplete:
            pref.siteLang=Preference.objects.get(userId=self.request.user.id).siteLang
            pref.accountType=Preference.objects.get(userId=self.request.user.id).accountType
            pref.currContentId=Preference.objects.get(userId=self.request.user.id).currContentId + 1
            pref.currLevel=Content.objects.get(id=pref.currContentId).level
            pref.userId=self.request.user
            pref.save()
            return self.create(request, *args, **kwargs)
        return False    

        
        # print(serialize.data)
        # return HttpResponse(serialize.data)    
    # queryset=Content.userId.through.objects.all()
    # serializer_class=ContentSerializer
    # def get_queryset(self):
    #     return Content.objects.filter(userId=self.request.user,)
    # # def get_queryset(self):
    #     return Content.objects.filter(id=Takes.objects.filter(isComplete=True, userId=self.request.user))
class DetailTakes(generics.RetrieveUpdateDestroyAPIView):
    # permission_classes=(ContentPermission,)
    queryset=Takes.objects.all()
    serializer_class=TakesSerializer
    # def put(self,request,*args,**kwargs):
    #     queryset=self.get_queryset
    #     serialize=TakesSerializer(queryset)
    #     print('hello')
    #     pref = Preference()
    #     pref.id = self.request.user.prefId.id  
    #     if request.user.prefId.currContentId==0:
    #         pref.currContentId=1
    #         pref.currLevel=Content.objects.get(id=pref.currContentId).level
    #         pref.save()
           
    #         return HttpResponse(serialize.data)
    #     elif Takes.objects.get(userId=request.user.id,contentId=request.user.prefId.currContentId).isComplete: 
    #         pref.currContentId=request.user.perfId.currContentId + 1
    #         pref.currLevel=Content.objects.get(id=pref.currContentId).level
    #         pref.save()
    #         return HttpResponse(serialize.data)