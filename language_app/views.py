from rest_framework import generics,permissions
from .models import Student,Preference,Course,Content,Quiz,Certificate,Grade
from .serializers import UserSerializer,PreferenceSerializer,CourseSerializer,ContentSerializer,QuizSerializer,CertificateSerializer,GradeSerializer
from .permissions import ReadOnly
class ListUser(generics.ListCreateAPIView):
    queryset = Student.objects.all()
    serializer_class = UserSerializer
class DetailUser(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (permissions.IsAuthenticated,ReadOnly,)
    queryset = Student.objects.all()
    serializer_class = UserSerializer
class ListPreference(generics.ListCreateAPIView):
    queryset=Preference.objects.all()
    serializer_class=PreferenceSerializer
class DetailPreference(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (ReadOnly,)
    queryset=Preference.objects.all()
    serializer_class=PreferenceSerializer
class ListCourse(generics.ListCreateAPIView):
    queryset=Course.objects.all()
    serializer_class=CourseSerializer
class DetailCourse(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (ReadOnly,)
    queryset=Course.objects.all()
    serializer_class=CourseSerializer
class ListContent(generics.ListCreateAPIView):
    queryset=Content.objects.all()
    serializer_class=ContentSerializer
class DetailContent(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (ReadOnly,)
    queryset=Content.objects.all()
    serializer_class=ContentSerializer
class ListQuiz(generics.ListCreateAPIView):
    queryset=Quiz.objects.all()
    serializer_class=QuizSerializer
class DetailQuiz(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (ReadOnly,)
    queryset=Quiz.objects.all()
    serializer_class=QuizSerializer
class ListCertificate(generics.ListCreateAPIView):
    queryset=Certificate.objects.all()
    serializer_class=CertificateSerializer
class DetailCertificate(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (ReadOnly,)
    queryset=Certificate.objects.all()
    serializer_class=CertificateSerializer
class ListGrade(generics.ListCreateAPIView):
    queryset=Grade.objects.all()
    serializer_class=GradeSerializer
class DetailGrade(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (ReadOnly,)
    queryset=Grade.objects.all()
    serializer_class=GradeSerializer


