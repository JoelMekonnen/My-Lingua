from django.conf.urls import include, url
from django.urls import path
from .views import HomePage, InstructorCreate, CourseCreateView, InstructorHomeView, CourseListView, CourseUpdateView, CreateQuiz
from django.conf.urls.static import static
from django.conf import settings
urlpatterns = [
    path('', HomePage.as_view(), name='home'),
    path('add/instructor/', InstructorCreate.as_view(), name='newInstructor'),
    path('add/course', CourseCreateView.as_view(), name='course'),
    path('home/instructor', InstructorHomeView.as_view(), name='instructorHome'),
    path('course/list', CourseListView.as_view(), name='courseList'),
    path('course/update/<int:pk>', CourseUpdateView.as_view(), name='courseUpdate'),
    path('add/quiz', CreateQuiz.as_view(), name='createQuiz')
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)   