from django.conf.urls import include, url
from django.urls import path
from .views import HomePage, InstructorCreate, CourseCreateView, InstructorHomeView, CourseListView, CourseUpdateView, CreateQuiz, ContentCreateView
from django.conf.urls.static import static
from django.conf import settings
from .views import AccountPref
urlpatterns = [
    path('', HomePage.as_view(), name='home'),
    path('add/instructor/', InstructorCreate.as_view(), name='newInstructor'),
    path('add/course', CourseCreateView.as_view(), name='course'),
    path('home/instructor', InstructorHomeView.as_view(), name='instructorHome'),
    path('course/list', CourseListView.as_view(), name='courseList'),
    path('content/create/<int:pk>', ContentCreateView.as_view(), name='contentCreate'), 
    path('course/update/<int:pk>', CourseUpdateView.as_view(), name='courseUpdate'),
    path('add/quiz/<int:pk>', CreateQuiz.as_view(), name='quizCreate'),
    path('account/update/<int:pk>', AccountPref.as_view(), name='accUpdate'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)   